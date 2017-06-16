name 'graylog_test'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures graylog_test'
long_description 'Installs/Configures graylog_test'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'graylog2'
depends 'elasticsearch'
depends 'java'
depends 'mongodb3'
