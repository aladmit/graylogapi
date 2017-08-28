require 'vcr'
require 'webmock/rspec'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!

  record_mode = ENV["VCR"] ? ENV["VCR"].to_sym : :once
  c.default_cassette_options = { :record => record_mode }
end

WebMock.disable_net_connect!(allow_localhost: true)
