describe GraylogAPI::Client, vcr: true do
  include_context 'graylogapi'
  let(:client) { graylogapi.client }

  context 'success requests' do
    let(:dashboard) do
      client.request(:post, '/dashboards', title: 'Test_Dashboard',
                                                description: 'Test_Dashboard')
    end

    let(:dashboard_id) do
      client.request(:get, '/dashboards')['dashboards']
            .select { |e| e['title'] = 'Test_Dashboard' }
            .first['id']
    end

    it 'post' do
      dash = client.request(:post, '/dashboards',
                                 title: 'Post Dashboard',
                                 description: 'post dashboard')
      expect(dash.keys).to include 'dashboard_id'
    end

    it 'get' do
      expect(client.request(:get, '/count/total').code).to eq 200
    end

    it 'put' do
      req = client.request(:put, "/dashboards/#{dashboard_id}",
                                title: 'Edited_Dashboard')
      expect(req.code).to eq 204
    end

    it 'delete' do
      request = client.request(:delete, "/dashboards/#{dashboard_id}")
      expect(request.code).to eq 204
    end

    it' return request' do
      request = client.request(:get, '/')
      expect(request.class).to eq GraylogAPI::Client::Response
    end
  end
end
