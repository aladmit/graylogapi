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
  end

  context 'request' do
    it 'struct have code' do
      request = client.request(:get, '/incorrect_page')
      expect(request.code.class).to eq Fixnum
    end

    it 'struct have body' do
      expect(client.request(:get, '/').body.class).to eq Hash
    end

    it 'return string if can`t parse body' do
      request = client.request(:get, '/incorrect_page')
      expect(request.body.class).to eq String
    end
  end
end
