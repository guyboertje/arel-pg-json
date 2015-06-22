require 'nodes/shared_node_examples'

module Arel
  module Nodes
    describe 'Postgres Json Nodes' do

      it_behaves_like 'A Binary Node', JsonDashArrow do |node|
        it "#{node} generates some sql" do
          sut = node.new(field_for(:jdata), Nodes.build_quoted('bar'))
          expect(compile(sut)).must_equal(%{"foobars"."jdata" -> 'bar'})
        end
      end

      it_behaves_like 'A Binary Node', JsonDashDoubleArrow do |node|
        it "#{node} generates some sql" do
          sut = node.new(field_for(:jdata), Nodes.build_quoted('bar'))
          expect(compile(sut)).must_equal(%{"foobars"."jdata" ->> 'bar'})
        end
      end

      it_behaves_like 'A Binary Node', JsonHashArrow do |node|
        it "#{node} generates some sql" do
          sut = node.new(field_for(:jdata), Nodes.build_quoted('{bar, baz}'))
          expect(compile(sut)).must_equal(%{"foobars"."jdata" #> '{bar, baz}'})
        end
      end

      it_behaves_like 'A Binary Node', JsonHashDoubleArrow do |node|
        it "#{node} generates some sql" do
          sut = node.new(field_for(:jdata), Nodes.build_quoted('{bar, baz}'))
          expect(compile(sut)).must_equal(%{"foobars"."jdata" #>> '{bar, baz}'})
        end
      end

      it_behaves_like 'A Binary Node', JsonbAtArrow do |node|
        it "#{node} generates some sql" do
          sut = node.new(field_for(:jdata), Nodes.build_quoted('{"bar": "baz"}'))
          expect(compile(sut)).must_equal(%{"foobars"."jdata" @> '{"bar": "baz"}'})
        end
      end

      it_behaves_like 'A Binary Node', JsonbArrowAt do |node|
        it "#{node} generates some sql" do
          sut = node.new(field_for(:jdata), Nodes.build_quoted('{"bar": "baz"}'))
          expect(compile(sut)).must_equal(%{"foobars"."jdata" <@ '{"bar": "baz"}'})
        end
      end

      it_behaves_like 'A Binary Node', JsonbQuestion do |node|
        it "#{node} generates some sql" do
          sut = node.new(field_for(:jdata), Nodes.build_quoted('bar'))
          expect(compile(sut)).must_equal(%{"foobars"."jdata" ? 'bar'})
        end
      end

      it_behaves_like 'A Binary Node', JsonbQuestionAnd do |node|
        it "#{node} generates some sql" do
          sut = node.new(field_for(:jdata), SqlLiteral.new("array['b', 'c']"))
          expect(compile(sut)).must_equal(%{"foobars"."jdata" ?& array['b', 'c']})
        end
      end

      it_behaves_like 'A Binary Node', JsonbQuestionOr do |node|
        it "#{node} generates some sql" do
          sut = node.new(field_for(:jdata), SqlLiteral.new("array['b', 'c']"))
          expect(compile(sut)).must_equal(%{"foobars"."jdata" ?| array['b', 'c']})
        end
      end

      it_behaves_like 'A Binary Node', CastJson do |node|
        it "#{node} generates some sql" do
          expected = %{CAST("foobars"."jdata" ->> 'age' AS int8) BETWEEN 18 AND 30}
          inner = JsonDashDoubleArrow.new(field_for(:jdata), Nodes.build_quoted('age'))
          sut = node.new(inner, SqlLiteral.new('int8'))
          outer = Between.new(sut, And.new([18, 30]))
          expect(compile(outer)).must_equal(expected)
        end
      end

    end
  end
end
