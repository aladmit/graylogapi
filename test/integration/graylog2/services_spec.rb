describe service('elasticsearch') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe service('mongod') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe service('graylog-server') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe http('http://localhost:9000/system/indexer/indices',
              auth: { user: 'admin', pass: 'admin' }) do
  its('status') { should eq 200 }
end
