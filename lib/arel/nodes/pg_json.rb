module Arel
  module Nodes
    %w{
      JsonDashArrow
      JsonDashDoubleArrow
      JsonHashArrow
      JsonHashDoubleArrow
      JsonbAtArrow
      JsonbArrowAt
      JsonbQuestionAnd
      JsonbQuestionOr
      CastJson
    }.each do |name|
      const_set name, Class.new(Binary)
    end
  end
end

=begin

support for CAST("table"."json_data" ->> 'start_i' AS int8) between 1428926200 AND 1428926600
will be
Between.new(
  CastJson.new(JsonDashDoubleArrow.new(field, path),'int8'),
  [1428926200, 1428926600]
)

JsonbAtArrow
"table"."json_data" @> '{"field1": "value1", "field2": "value2"}'

JsonbArrowAt
"table"."json_data" <@ '{"field1": "value1", "field2": "value2"}'

JsonbQuestionOr
path ?| text e.g. "table"."json_data" -> 'tags' ?| array['fruit','vegetable']

JsonbQuestionAnd
path ?& text e.g. "foods"."json_data" -> 'tags' ?& array['red','fruit']

Operator  Right Operand Type  Description Example Example Result
->        int           Get   JSON array element (indexed from zero)  '[{"a":"foo"},{"b":"bar"},{"c":"baz"}]'::json->2  {"c":"baz"}
->        text          Get   JSON object field by key                '{"a": {"b":"foo"}}'::json->'a' {"b":"foo"}
->>       int           Get   JSON array element as text              '[1,2,3]'::json->>2 3
->>       text          Get   JSON object field as text               '{"a":1,"b":2}'::json->>'b' 2
#>        text[]        Get   JSON object at specified path           '{"a": {"b":{"c": "foo"}}}'::json#>'{a,b}'  {"c": "foo"}
#>>       text[]        Get   JSON object at specified path as text   '{"a":[1,2,3],"b":[4,5,6]}'::json#>>'{a,2}' 3

=end
