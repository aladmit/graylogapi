describe GraylogAPI::Client, vcr: true do
  include_context 'graylogapi'
  let(:client) { graylogapi.client }

  context 'success requests' do
    let(:dashboard) do
      client.post('/dashboards', title: 'Test_Dashboard',
                                 description: 'Test_Dashboard')
    end

    let(:dashboard_id) do
      client.get('/dashboards').body['dashboards']
            .select { |e| e['title'] = 'Test_Dashboard' }
            .first['id']
    end

    it 'post' do
      dash = client.post('/dashboards', title: 'Post Dashboard',
                                        description: 'post dashboard')
      expect(dash.body.keys).to include 'dashboard_id'
    end

    it 'get' do
      expect(client.get('/count/total').code).to eq 200
    end

    it 'put' do
      req = client.put("/dashboards/#{dashboard_id}", title: 'Edited_Dashboard')
      expect(req.code).to eq 204
    end

    it 'delete' do
      expect(client.delete("/dashboards/#{dashboard_id}").code).to eq 204
    end
  end

  context 'json_request' do
    %w[get post put delete].each do |method|
      it "#{method} use json_request method" do
        expect(client).to receive(:json_request)
        client.send(method, '/incorrect_page')
      end
    end

    it 'struct have code' do
      expect(client.get('/incorrect_page').code.class).to eq Fixnum
    end

    it 'struct have body' do
      expect(client.get('/').body.class).to eq Hash
    end

    it 'return string if can`t parse body' do
      expect(client.get('/incorrect_page').body.class).to eq String
    end
  end
end
