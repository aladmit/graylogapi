describe 'client', vcr: true do
  include_context 'graylogapi'
  let(:client) { graylogapi.client }

  context 'success requests' do
    it 'get' do
      expect(client.get('/count/total').code).to eq 200
    end

    it 'post' do
      dashboard = client.post('/dashboards', title: 'Post Dashboard',
                                             description: 'post dashboard')
      expect(dashboard.body.keys).to include 'dashboard_id'
    end

    it 'put' do
      client.post('/dashboards', title: 'Put Dashboard',
                                 description: 'Put Dashboard')
      id = client.get('/dashboards').body['dashboards']
                 .select { |e| e['title'] == 'Put Dashboard' }
                 .first['id']
      request = client.put("/dashboards/#{id}", title: 'Put_Dashboard')
      expect(request.code).to eq 204
    end

    it 'delete' do
      client.post('/dashboards', title: 'Delete Dashboard',
                                 description: 'Delete Dashboard')
      id = client.get('/dashboards').body['dashboards']
                 .select { |e| e['title'] == 'Delete Dashboard' }
                 .first['id']
      expect(client.delete("/dashboards/#{id}").code).to eq 204
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
