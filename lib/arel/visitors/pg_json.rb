module Arel
  module Visitors
    module PgJson
      private

      def visit_Arel_Nodes_JsonDashArrow o, collector
        json_infix o, collector, ' -> '
      end

      def visit_Arel_Nodes_JsonDashDoubleArrow o, collector
        json_infix o, collector, ' ->> '
      end

      def visit_Arel_Nodes_JsonHashArrow o, collector
        json_infix o, collector, ' #> '
      end

      def visit_Arel_Nodes_JsonHashDoubleArrow o, collector
        json_infix o, collector, ' #>> '
      end

      def json_infix(o, collector, opr)
        collector = visit o.left, collector
        collector << opr
        visit o.right, collector
      end
    end

    PostgreSQL.send :include, PgJson
  end
end
