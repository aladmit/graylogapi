describe GraylogAPI::Dashboards, vcr: true do
  include_context 'graylogapi'

  context 'create' do
    subject(:response) do
      dash = graylogapi.dashboards.create(title: 'create', description: 'create')
      graylogapi.dashboards.delete(dash['dashboard_id'])
      dash
    end

    it 'code 201' do
      expect(response.code).to eq 201
    end

    it 'have id' do
      expect(response.keys).to include 'dashboard_id'
    end
  end

  context 'all' do
    subject(:response) do
      graylogapi.dashboards.all
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'have total' do
      expect(response.keys).to include 'total'
    end

    it 'have dashboards' do
      expect(response.keys).to include 'dashboards'
    end
  end

  context 'by_id' do
    subject(:response) do
      dash = graylogapi.dashboards.create(title: 'id', description: 'id')
      res = graylogapi.dashboards.by_id(dash['dashboard_id'])
      graylogapi.dashboards.delete(dash['dashboard_id'])
      res
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'have id' do
      expect(response.keys).to include 'id'
    end

    it 'have title' do
      expect(response.keys).to include 'title'
    end
  end

  context 'update' do
    subject(:response) do
      dash = graylogapi.dashboards.create(title: 'update', description: 'update')
      res = graylogapi.dashboards.update(dash['dashboard_id'], title: 'updated',
                                                               description: 'updated')
      graylogapi.dashboards.delete(dash['dashboard_id'])
      res
    end

    it 'code 204' do
      expect(response.code).to eq 204
    end
  end

  context 'delete' do
    subject(:response) do
      dash = graylogapi.dashboards.create(title: 'delete', description: 'delete')
      graylogapi.dashboards.delete(dash['dashboard_id'])
    end

    it 'code 204' do
      expect(response.code).to eq 204
    end
  end
end
