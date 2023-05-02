--- Creates a ancestor specific query string
---@param ancestor_name string The name fo the string in the test block/function
---@return string the raw `treesitter` query string
local test_function_query_string = function(ancestor_name)
	return string.format(
		[[ 
(call_expression
  function: [
    (identifier) @function-name
    (member_expression
      object: (identifier) @function-name
      _*)
  ]
  arguments: (arguments
    (string
      (string_fragment) @test-name
      (#eq? @test-name %s)
    ) 
    (arrow_function ; should probably change this to something general
      (statement_block
        (expression_statement
          (call_expression
            function: [
              (identifier) @function-call
              (member_expression
                object: (identifier) @function-call
                _*)
            ]
            arguments: (arguments
              (string
                (string_fragment) @string-arg
              ) 
            ) @function-args
            (#match? @function-call "(it)|(test)")
          )
        )
      )
    )
  ) @function-params
  (#eq? @function-name "describe")
)
    ]],
		ancestor_name
	)
end

return test_function_query_string
