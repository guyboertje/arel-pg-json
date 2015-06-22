$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
$:.unshift File.expand_path(File.dirname(__FILE__))

require 'arel_pg_json'
require 'minitest/autorun'

if !Arel::Nodes.respond_to?(:build_quoted)
  module Arel
    module Nodes
      def self.build_quoted(val)
        SqlLiteral.new(val.prepend(?').concat(?'))
      end
    end
  end
end

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
  if defined?(Arel::Collectors)
    PgVisitor.accept(node, Arel::Collectors::SQLString.new).value
  else
    PgVisitor.accept(node)
  end
end

def field_for(str)
  TestTable[str.to_sym]
end

def equality_wrap(left, right)
   Arel::Nodes::Equality.new(left, Arel::Nodes.build_quoted(right))
end
