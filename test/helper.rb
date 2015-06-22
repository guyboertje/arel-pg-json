$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
$:.unshift File.expand_path(File.dirname(__FILE__))

require 'arel_pg_json'
require 'minitest/autorun'

require 'support/fake_record'
Arel::Table.engine = FakeRecord::Base.new

PgVisitor = Arel::Visitors::PostgreSQL.new Arel::Table.engine.connection

TestTable = Arel::Table.new(:foobars)

MiniTest::Spec.class_eval do
  def self.shared_examples
    @shared_examples ||= Hash.new.tap{ |h| h.default = ->(*){} }
  end
end

def shared_examples_for(desc, &block)
  MiniTest::Spec.shared_examples[desc] = block
end

def it_behaves_like(desc, *args, &block)
  describe desc do
    self.instance_exec(*args, &MiniTest::Spec.shared_examples[desc])
    self.instance_exec(*args, &block) if block_given?
  end
end

def compile node
  PgVisitor.accept(node, Arel::Collectors::SQLString.new).value
end

def field_for(str)
  TestTable[str.to_sym]
end

def equality_wrap(left, right)
   Arel::Nodes::Equality.new(left, Arel::Nodes.build_quoted(right))
end
# Arel::Collectors::SQLString.new Collector.new
