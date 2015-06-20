$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
$:.unshift File.expand_path(File.dirname(__FILE__))


require "arel_pg_json"
require 'minitest/autorun'
