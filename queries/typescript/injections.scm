;; inherits: typescript
;; extends
(call_expression
  function: (member_expression
    property: (property_identifier) @method
    (#match? @method "^\\$executeRaw$")
  )
  arguments: (template_string) @sql
)
