describe 'client', vcr: true do
  include_context 'client'

  context 'get request' do
    context 'success' do
      it 'return hash from body' do
        expect(client.get('/count/total').class).to eq Hash
      end
    end

    context 'fail' do
      it 'if body is empty return Net' do
        expect(client.get('/').class).to eq Net::HTTPTemporaryRedirect
      end
    end
  end

  context 'post request' do
    context 'success' do
      subject do
        client.post('/dashboards', title: 'Test Dashboard',
                                   description: 'test description')
      end

      it 'return hash from body' do
        expect(subject.class).to eq Hash
        expect(subject.keys).to include 'dashboard_id'
      end
    end
  end

  it 'delete request' do
    client.post('/dashboards', title: 'Test delete',
                               description: 'test delete')
    dashboard_id = client.get('/dashboards')['dashboards']
                         .select { |e| e['title'] == 'Test delete' }
                         .first['id']
    expect(client.delete("/dashboards/#{dashboard_id}").code).to eq '204'
  end

  it 'put request' do
    client.post('/dashboards', title: 'Test put',
                               description: 'test put')
    dashboard_id = client.get('/dashboards')['dashboards']
                         .select { |e| e['title'] == 'Test put' }
                         .first['id']
    request = client.put("/dashboards/#{dashboard_id}", title: 'success')
    expect(request.code).to eq '204'
  end
end
