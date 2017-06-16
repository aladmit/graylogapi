default['java'].tap do |java|
  java['jdk_version'] = '8'
  java['install_flavor'] = 'oracle'
  java['oracle']['accept_oracle_download_terms'] = true
end

default['elasticsearch'].tap do |elastic|
  elastic['version'] = '2.4.4'
  elastic['allocated_memory'] = '3G'
end

default['graylog2'].tap do |graylog|
  graylog['password_secret'] = '2jueVqZpwLLjaWxV'
  graylog['root_password_sha2'] = '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918'
  graylog['root_timezone'] = 'UTC'
  graylog['server']['java_opts'] = '-XX:+UseConcMarkSweepGC -XX:+CMSPermGenSweepingEnabled -XX:+CMSClassUnloadingEnabled -Xmx2096m -Djava.net.preferIPv4Stack=true'
  graylog['rest']['listen_uri'] = 'http://0.0.0.0:9000/api/'
  graylog['web']['listen_uri'] = 'http://0.0.0.0:9000'
  graylog['sidcar']['server_url'] = 'http://localhost:900/api'

  graylog['elasticsearch']['cluster_name'] = 'elasticsearch'
end
