require 'rubygems'
require 'bundler/setup'

Bundler.require

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do

end
