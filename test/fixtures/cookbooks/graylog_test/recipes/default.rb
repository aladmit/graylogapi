#
# Cookbook:: graylog_test
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'java'
include_recipe 'elasticsearch'

service 'elasticsearch' do
  action [:start, :enable]
end

include_recipe 'mongodb3'
include_recipe 'graylog2'
include_recipe 'graylog2::server'
