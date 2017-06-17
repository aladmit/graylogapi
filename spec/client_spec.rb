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
end
