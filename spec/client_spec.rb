describe 'client', vcr: true do
  include_context 'graylogapi'
  let(:client) { graylogapi.client }

  context 'success requests' do
    it 'get' do
      expect(client.get('/count/total').class).to eq Hash
    end

    it 'post' do
      dashboard = client.post('/dashboards', title: 'Post Dashboard',
                                             description: 'post dashboard')
      expect(dashboard.keys).to include 'dashboard_id'
    end

    it 'put' do
      client.post('/dashboards', title: 'Put Dashboard',
                                 description: 'Put Dashboard')
      id = client.get('/dashboards')['dashboards']
                 .select { |e| e['title'] == 'Put Dashboard' }
                 .first['id']
      request = client.put("/dashboards/#{id}", title: 'Put_Dashboard')
      expect(request.code).to eq '204'
    end

    it 'delete' do
      client.post('/dashboards', title: 'Delete Dashboard',
                                 description: 'Delete Dashboard')
      id = client.get('/dashboards')['dashboards']
                 .select { |e| e['title'] == 'Delete Dashboard' }
                 .first['id']
      expect(client.delete("/dashboards/#{id}").code).to eq '204'
    end
  end

  context 'fail requests' do
    it 'return Net object' do
      expect(client.get('/incorrect_page').class).to eq Net::HTTPOK
    end
  end

  context 'json_request' do
    %w[get post put delete].each do |method|
      it "#{method} use json_request method" do
        expect(client).to receive(:json_request)
        client.send(method, '/incorrect_page')
      end
    end

    it 'return Net object if can`t parse response body' do
      expect(client.get('/incorrect_page').class).to eq Net::HTTPOK
    end
  end
end
