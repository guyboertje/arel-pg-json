module Arel
  module Visitors
    module PgJson
      private

      def visit_Arel_Nodes_CastJson o, a
        'CAST('.concat(
          visit(o.left, a).concat(' AS ').concat(o.right)
        ).concat(')')
      end

      def visit_Arel_Nodes_JsonDashArrow o, a
        json_infix o, a, ' -> '
      end

      def visit_Arel_Nodes_JsonDashDoubleArrow o, a
        json_infix o, a, ' ->> '
      end

      def visit_Arel_Nodes_JsonHashArrow o, a
        json_infix o, a, ' #> '
      end

      def visit_Arel_Nodes_JsonHashDoubleArrow o, a
        json_infix o, a, ' #>> '
      end

      def visit_Arel_Nodes_JsonbAtArrow o, a
        json_infix o, a, ' @> '
      end

      def visit_Arel_Nodes_JsonbArrowAt o, a
        json_infix o, a, ' <@ '
      end

      def visit_Arel_Nodes_JsonbQuestionAnd o, a
        json_infix o, a, ' ?& '
      end

      def visit_Arel_Nodes_JsonbQuestionOr o, a
        json_infix o, a, ' ?| '
      end

      def json_infix(o, a, opr)
        a = o.left if Arel::Attributes::Attribute === o.left
        visit(o.left, a).concat(opr).concat(visit(o.right, a))
      end
    end

    PostgreSQL.send :include, PgJson
  end
end
