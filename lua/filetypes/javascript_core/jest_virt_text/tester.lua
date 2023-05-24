local Tester = {
	bufnr = nil,
	file_path = nil,
	file_name_no_ext = nil,
	filetype = nil,
	allowed_filetypes = nil,
	filename_matches = nil,
	test_data = nil,
}

--- Tester class method to ensure the filetype we are running our tests on is valid
function Tester:check_filetype()
	if not vim.list_contains(self.allowed_filetypes, self.filetype) then
		error(
			"Attempted to test a file which has not been specified in the confit. Currently the only filteypse configured for testing are:"
				.. vim.json.encode(self.allowed_filetypes)
		)
	end
end

--- Tester class method to ensure that the filetype strings we specify match
function Tester:check_file_string()
	local filename_matchers = vim.tbl_map(vim.regex, self.filename_matches)
	local filename_matches = vim.tbl_map(function(filename_matcher)
		return filename_matcher:match_str(self.file_name_no_ext)
	end, filename_matchers)
	if #filename_matches == 0 then
		error(
			"Attempted to test a test file which did not match any of the filename regex patterns. The current filename patterns are:"
				.. vim.json.encode(self.filename_matches)
		)
	end
end

function Tester:set_test_data(test_data)
	self.test_data = test_data
end

function Tester:new()
	local bufnr = vim.fn.bufnr()
	self.bufnr = bufnr
	self.file_path = vim.fn.expand("%:p")
	self.file_name_no_ext = vim.fn.expand("%:r")
	self.filetype = vim.filetype.match({ buf = bufnr })
	self.allowed_filetypes = { "javascript", "typescript" }
	self.filename_matches = { [[.*\.test$]] }
	-- Run our checks to make sure we can run tests
	Tester.check_filetype(self)
	Tester.check_file_string(self)
	return self
end

return Tester
