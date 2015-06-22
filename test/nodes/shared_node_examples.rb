require 'helper'

shared_examples_for 'A Binary Node' do |node|
  describe 'construction' do
    it 'requires two arguments' do
      err = ->{ node.new }.must_raise ArgumentError
      err.message.must_match %r{wrong number of arguments \(0 for 2\)}
    end

    it 'creates a new instance' do
      instance = node.new('foo', 'bar')
      expect(instance.left).must_equal('foo')
      expect(instance.right).must_equal('bar')
      expect(instance).must_be_kind_of(Arel::Nodes::Binary)
    end
  end
end
