module Arel
  module Visitors
    module PgJson
      private

      def visit_Arel_Nodes_JsonDashArrow o, collector
        infix_value o, collector, ' -> '
      end

      def visit_Arel_Nodes_JsonDashDoubleArrow o, collector
        infix_value o, collector, ' ->> '
      end

      def visit_Arel_Nodes_JsonHashArrow o, collector
        infix_value o, collector, ' #> '
      end

      def visit_Arel_Nodes_JsonHashDoubleArrow o, collector
        infix_value o, collector, ' #>> '
      end
    end

    PostgreSQL.send :include, PgJson
  end
end
