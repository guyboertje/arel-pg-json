module Arel
  module Visitors
    module PgJson
      private

      def visit_Arel_Nodes_CastJson o, collector
        if !collector.respond_to?('<<') # for arel < 6.0.0
          return visit(o.left, collector)
            .prepend('CAST(')
            .concat(' AS ')
            .concat(o.right)
            .concat(?))
        else
          collector << 'CAST('
          collector = visit(o.left, collector)
          collector << " AS #{o.right})"
        end
        collector
      end

      def visit_Arel_Nodes_JsonDashArrow o, a
        json_infix o, a, '->'
      end

      def visit_Arel_Nodes_JsonDashDoubleArrow o, a
        json_infix o, a, '->>'
      end

      def visit_Arel_Nodes_JsonHashArrow o, a
        json_infix o, a, '#>'
      end

      def visit_Arel_Nodes_JsonHashDoubleArrow o, a
        json_infix o, a, '#>>'
      end

      def visit_Arel_Nodes_JsonbAtArrow o, a
        json_infix o, a, '@>'
      end

      def visit_Arel_Nodes_JsonbArrowAt o, a
        json_infix o, a, '<@'
      end

      def visit_Arel_Nodes_JsonbQuestion o, a
        json_infix o, a, '?'
      end

      def visit_Arel_Nodes_JsonbQuestionAnd o, a
        json_infix o, a, '?&'
      end

      def visit_Arel_Nodes_JsonbQuestionOr o, a
        json_infix o, a, '?|'
      end

      def json_infix(o, a, opr)
        visit(Nodes::InfixOperation.new(opr, o.left, o.right), a)
      end
    end

    PostgreSQL.send :include, PgJson
  end
end
