local Tester = require("filetypes.javascript_core.jest_virt_text.tester")
local config = {
	filetypes = { "javascript", "typescript" },
	filename_matches = { [[.*\.test$]] },
}
local tester = Tester.new(config)

local M = {}

local query_string_factory =
	require("filetypes.javascript_core.jest_virt_text.query_string_factory")
local tools = require("utils.helpers")

local q = require("vim.treesitter")
local ts_helpers = require("utils.treesitter-helpers")
local filetype = nil

local test_result_ns = vim.api.nvim_create_namespace("jest-tests")
local testing_status_ns = vim.api.nvim_create_namespace("jest-test-status")
local status_codes = {
	passed = { " ✅ ", "RedrawDebugComposed" },
	failed = { " 💀 ", "RedrawDebugRecompose" },
	pending = { " 💤 ", "lualine_a_insert" },
}

local get_buffer_root_node = function(bufnr)
	local parser = vim.treesitter.get_parser(bufnr, filetype, {})
	local tree = parser:parse()[1]
	return tree:root()
end

local find_test_line = function(bufnr, input)
	local closest_ancestor_name = input.ancestorTitles[#input.ancestorTitles]
	local query_string = query_string_factory(closest_ancestor_name)
	local query = vim.treesitter.query.parse(tester.filetype, query_string)
	local root = get_buffer_root_node(bufnr)

	for _, nodes in query:iter_matches(root, bufnr, 0, -1) do
		local immediate_describe_node = nodes[2]
		local test_arg = nodes[4]

		local test_parent_nodes =
			ts_helpers.get_all_parent_nodes(immediate_describe_node)
		local function_nodes = vim.tbl_filter(function(node)
			return node:type() == "call_expression"
		end, test_parent_nodes)
		local function_call_nodes = vim.tbl_map(function(node)
			return node:child(0)
		end, function_nodes)
		local describe_nodes = vim.tbl_filter(function(node)
			local node_text = q.get_node_text(node, bufnr)
			return node_text:match("^describe")
		end, function_call_nodes)
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
		local ordered_describe_strings =
			tools.reverse_list_table(describe_strings)

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

--- Return our parsed json test data
---@param json string
---@return table<string, any> | nil
local function parse_jest_json(json)
	local result = vim.json.decode(json)
	return result and result.testResults[1].assertionResults
end

local build_test_result = function(bufnr, result)
	local test_line_number = find_test_line(bufnr, result)
	if test_line_number then
		return {
			line_num = test_line_number,
			test_status = result.status,
			failure_narrative = result.failureMessages,
		}
	end
end

--- Parses our test data
---@param bufnr integer buffer number to attach to
---@param data string json output data from our test
local process_tests = function(bufnr, data)
	local jest_results = parse_jest_json(data)
	if not jest_results then
		return
	end
	local test_results = vim.tbl_map(function(jest_result)
		return build_test_result(bufnr, jest_result)
	end, jest_results)
	P(test_results)
	for _, result in ipairs(test_results) do
		vim.api.nvim_buf_set_extmark(bufnr, test_result_ns, result.line_num, 0, {
			virt_text = { status_codes[result.test_status] },
		})
	end
end

M.test = function()
	vim.api.nvim_buf_clear_namespace(tester.bufnr, test_result_ns, 0, -1)
	vim.api.nvim_buf_set_extmark(tester.bufnr, testing_status_ns, 0, 0, {
		virt_text = { { " TESTING ", "RedrawDebugComposed" } },
		virt_text_pos = "right_align",
	})
	vim.fn.jobstart({
		"npx",
		"--node-options=--experimental-vm-modules",
		"jest",
		"--json",
		"--silent",
		tester.file_path,
	}, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			local test_data = data[1]
			-- tester:set_test_data(test_data)
			local success, result = pcall(function()
				process_tests(tester.bufnr, data[1])
			end)
			if not success then
				print("your tests failed to run", result)
			end
			vim.api.nvim_buf_clear_namespace(
				tester.bufnr,
				testing_status_ns,
				0,
				-1
			)
		end,
	})
end

return M
