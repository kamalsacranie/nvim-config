local M = {}
local q = require("vim.treesitter.query")
local ts_helpers = require("utils.treesitter-helpers")
local filetype = nil

local test_function_query_string = function(ancestor_name)
	return [[ 
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
      (#eq? @test-name "]] .. ancestor_name .. [[")
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
]]
end

local function reverse_list_table(list)
	local len = #list
	local result = vim.deepcopy(list)
	for i = 1, math.floor(len / 2) do
		result[i], result[len - i + 1] = result[len - i + 1], result[i]
	end
	return result
end

local find_test_line = function(bufnr, input)
	local closest_ancestor_name = input.ancestorTitles[#input.ancestorTitles]
	local raw_query = test_function_query_string(closest_ancestor_name)
	local formatted = string.format(raw_query)
	local query = vim.treesitter.parse_query(filetype, formatted)
	local parser = vim.treesitter.get_parser(bufnr, filetype, {})
	local tree = parser:parse()[1]
	local root = tree:root()

	for _, nodes in query:iter_matches(root, bufnr, 0, -1) do
		local immediate_describe_node = nodes[2]
		local test_arg = nodes[4]

		local test_parent_nodes =
			ts_helpers.get_all_parent_nodes(immediate_describe_node)
		local function_nodes = filter(test_parent_nodes, function(node)
			return node:type() == "call_expression"
		end)
		local function_call_nodes = vim.tbl_map(function(node)
			return node:child(0)
		end, function_nodes)
		local describe_nodes = filter(function_call_nodes, function(node)
			local node_text = q.get_node_text(node, bufnr)
			return node_text:match("^describe")
		end)
		local describe_string_nodes = vim.tbl_map(function(node)
			return node
				:next_sibling() -- arguments node parent
				:child(0) -- arguments node
				:next_sibling() -- first argument
				:child(0) -- opening bracket
				:next_sibling() -- argument 1 substring
		end, describe_nodes)
		local describe_strings = vim.tbl_map(function(node)
			return q.get_node_text(node, bufnr)
		end, describe_string_nodes)
		local ordered_describe_strings = reverse_list_table(describe_strings)

		local test_string = q.get_node_text(test_arg, bufnr)
		local test_line_number = test_arg:range()
		-- if we match our test name and also all of it's title ancestors
		if
			test_string == input.title
			and table.concat(ordered_describe_strings)
				== table.concat(input.ancestorTitles)
		then
			return test_line_number
		end
	end
	return false
end

local process_tests = function(bufnr, data)
	if not data then
		return
	end
	local jest_output = vim.json.decode(data[1])
	-- All relevant information is contained in the assertionResults part of our json. This is a list
	local jest_results = jest_output.testResults[1].assertionResults
	local test_results = vim.tbl_map(function(result)
		local test_line_number = find_test_line(bufnr, result)
		if test_line_number then
			return { line_num = test_line_number, test_status = result.status }
		end
	end, jest_results)
	local ns = vim.api.nvim_create_namespace("jest-tests")
	-- Clear the namespace every time we run the tests
	vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
	for _, result in ipairs(test_results) do
		local text = {
			passed = { "  ", "RedrawDebugComposed" },
			failed = { " ﮊ ", "RedrawDebugRecompose" },
			pending = { " 💤 ", "lualine_a_insert" },
		}
		vim.api.nvim_buf_set_extmark(bufnr, ns, result.line_num, 0, {
			virt_text = { text[result.test_status] },
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
	local bufnr = vim.fn.bufnr()
	vim.fn.jobstart({
		"npx",
		"--node-options=--experimental-vm-modules",
		"jest",
		"--json",
		"--silent",
		file_path,
	}, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			process_tests(bufnr, data)
		end,
	})
end

return M
