local M = {}
local q = require("vim.treesitter.query")
local filetype = nil

local test_function_query_string = function(ancestor_name)
	return [[ 
(call_expression
  function: (identifier) @function-name
  arguments: (arguments
    (string
      (string_fragment) @test-name
      (#eq? @test-name "]] .. ancestor_name .. [[")
    ) 
    (arrow_function ; should probably change this to something general
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
end

local function get_all_parent_nodes(node)
	local result = {}
	local immediate_parent = node:parent() or nil
	if not immediate_parent then
		return result
	end
	table.insert(result, immediate_parent)
	local ancestors = get_all_parent_nodes(immediate_parent)
	for _, parent in ipairs(ancestors) do
		table.insert(result, parent)
	end
	return result
end

local find_test_line = function(input)
	local closest_ancestor_name = input.ancestorTitles[#input.ancestorTitles]
	local raw_query = test_function_query_string(closest_ancestor_name)
	local formatted = string.format(raw_query)
	local query = vim.treesitter.parse_query(filetype, formatted)
	local parser = vim.treesitter.get_parser(0, filetype, {})
	local tree = parser:parse()[1]
	local root = tree:root()

	for _, nodes in query:iter_matches(root, 0, 0, -1) do
		local immediate_describe_node = nodes[2]
		local test_parent_nodes = get_all_parent_nodes(immediate_describe_node)
		local function_nodes = filter(test_parent_nodes, function(node)
			return node:type() == "call_expression"
		end)
		local function_call_nodes = map(function_nodes, function(node)
			return node:child(0)
		end)
		local describe_nodes = filter(function_call_nodes, function(node)
			return q.get_node_text(node, 0) == "describe"
		end)
		local describe_string_nodes = map(describe_nodes, function(node)
			return node:next_sibling()
				:child(0)
				:next_sibling()
				:child(0)
				:next_sibling()
		end)
		local describe_strings = map(describe_string_nodes, function(node)
			return q.get_node_text(node, 0)
		end)
		local test_arg = nodes[4]
		local test_string = q.get_node_text(test_arg, 0)
		local test_line_number = test_arg:range()
		if test_string == input.title then
			return describe_strings, test_line_number
		end
	end
	return {}, false
end

local process_tests = function(_, data)
	if not data then
		return
	end
	local jest_output = vim.json.decode(data[1])
	-- All relevant information is contained in the assertionResults part of our json. This is a list
	local jest_results = jest_output.testResults[1].assertionResults
	local test_results = map(jest_results, function(result)
		local describes, test_line_number = find_test_line(result)
		table.sort(describes, function(x, y)
			return x < y
		end)
		if
			test_line_number
			and table.concat(describes)
				== table.concat(result.ancestorTitles)
		then
			return { line_num = test_line_number, test_status = result.status }
		end
	end)
	local ns = vim.api.nvim_create_namespace("jest-tests")
	-- Clear the namespace every time we run the tests
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
end

M.test = function()
	-- Get absolute filepath
	local file_path = vim.fn.expand("%:p")
	local test_file_regex = vim.regex([[.*\.test\.[tj]s$]])
	if vim.fn.expand("%:e") == "js" then
		filetype = "javascript"
	else
		filetype = "typescript"
	end
	-- TODO: check we are in an npm repo with jest installed
	if not test_file_regex:match_str(file_path) then
		return
	end
	vim.fn.jobstart({
		"npx",
		"jest",
		file_path,
		"--json",
		"--silent",
	}, {
		stdout_buffered = true,
		on_stdout = process_tests,
	})
end

-- TODO: make the treesitter query get all parent describe blocks so we can be 100% accurate
-- we could either do this by getting the parent of the describe node until it is no longer a describe node or
-- we could build a table of the strucutre of the test file by making a query for all describe nodes. Kind
-- the same thing?

return M
