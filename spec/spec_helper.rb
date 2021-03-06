require 'graylogapi'
require_relative './support/webmock'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context 'graylogapi' do
  let(:graylogapi) do
    GraylogAPI.new(base_url: 'http://localhost:9000/api',
                   user: 'admin',
                   pass: 'admin')
  end

  def generate_string(length = 8)
    [*('a'..'z')].sample(length).join
  end
end
