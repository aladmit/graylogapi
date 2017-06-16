libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'graylogapi/version'
require 'graylogapi/client'
require 'graylogapi/alerts'
