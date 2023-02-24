-- TODO: we should rather edit our query in the commented out part of our query
local test_function_query_string = [[ 
(call_expression
  function: (identifier) @function-name
  arguments: (arguments
    (string
      (string_fragment) @test-name
      ; (#eq? @test-name "add")
    ) 
    (arrow_function
      (statement_block
        (expression_statement
          (call_expression
            function: (identifier) @function-call
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
]]

local find_test_line = function(input)
	local formatted = string.format(test_function_query_string, "add")
	local query = vim.treesitter.parse_query("javascript", formatted)
	local parser = vim.treesitter.get_parser(0, "javascript", {})
	local tree = parser:parse()[1]
	local root = tree:root()

	local test_keys = {}
	for id, node in query:iter_captures(root, 0, 0, -1) do
		-- 2 is the describe name, 4 is the it/test string
		if id == 2 or id == 4 then
			local range = { node:range() }
			local line = range[1]
			-- range our our text in buffer line
			local from, to = range[2] + 1, range[4]
			local line_text =
				vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1]
			local query_string = string.sub(line_text, from, to)
			if id == 2 then
				test_keys["name"] = query_string
			end
			if id == 4 then
				test_keys["test"] = query_string
				test_keys["line"] = line
			end
		end
		if
			test_keys.test == input.title
			and test_keys.name
				== input.ancestorTitles[#input.ancestorTitles]
		then
			return true, test_keys.line
		end
	end
	return false, false
end
vim.keymap.set("n", "<leader><leader>q", find_test_line)

vim.keymap.set("n", "<leader><leader>t", function()
	local current_file = vim.fn.expand("%:p")
	-- regex to see if test file .*\.test\.[tj]s$
	local test_file_regex = vim.regex([[.*\.test\.[tj]s$]])
	if not test_file_regex:match_str(current_file) then
		return
	end
	vim.fn.jobstart({
		"npx",
		"jest",
		current_file,
		"--json",
		"--silent",
	}, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			if not data then
				return
			end
			local jest_output = vim.json.decode(data[1])
			local jest_results = jest_output.testResults[1].assertionResults
			local test_results = map(jest_results, function(result)
				-- local name_of_test =
				-- 	vim.regex(result.title .. "[" .. [['"]] .. "]" .. [[,]])
				-- for line_num, line in
				-- 	ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false))
				-- do
				-- 	if name_of_test:match_str(line) then
				-- 		return {
				-- 			line_num = line_num - 1,
				-- 			test_status = result.status,
				-- 		}
				-- 	end
				-- end
				local yes, gog = find_test_line(result)
				if yes then
					return { line_num = gog, test_status = result.status }
				end
			end)
			P(test_results)
			local ns = vim.api.nvim_create_namespace("live-tests")
			vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
			for _, result in ipairs(test_results) do
				local text = { " ﮊ ", "RedrawDebugRecompose" }
				if result.test_status == "passed" then
					text = { "  ", "RedrawDebugComposed" }
				end
				vim.api.nvim_buf_set_extmark(0, ns, result.line_num, 0, {
					virt_text = { text },
				})
			end
		end,
	})
end)
