module Arel
  module Nodes
    %w{
      JsonDashArrow
      JsonDashDoubleArrow
      JsonHashArrow
      JsonHashDoubleArrow
      JsonbAtArrow
    }.each do |name|
      const_set name, Class.new(Binary)
    end
  end
end

__END__
JsonbAtArrow
@> '{"state": "pencilled", "domain_event": "appointment_pencil"}'

Operator  Right Operand Type  Description Example Example Result
->        int           Get   JSON array element (indexed from zero)  '[{"a":"foo"},{"b":"bar"},{"c":"baz"}]'::json->2  {"c":"baz"}
->        text          Get   JSON object field by key                '{"a": {"b":"foo"}}'::json->'a' {"b":"foo"}
->>       int           Get   JSON array element as text              '[1,2,3]'::json->>2 3
->>       text          Get   JSON object field as text               '{"a":1,"b":2}'::json->>'b' 2
#>        text[]        Get   JSON object at specified path           '{"a": {"b":{"c": "foo"}}}'::json#>'{a,b}'  {"c": "foo"}
#>>       text[]        Get   JSON object at specified path as text   '{"a":[1,2,3],"b":[4,5,6]}'::json#>>'{a,2}' 3
