$:.unshift(File.expand_path('../lib', __FILE__))
$:.unshift(File.expand_path('../support/thrift', __FILE__))

require 'rspec'
require 'byebug'

require 'accounts_service'
require 'thrift/local_type_checking'
