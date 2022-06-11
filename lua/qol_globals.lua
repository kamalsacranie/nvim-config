-- Quality of life global functions
-- Defining some useful global functions we can use

-- Making it easier to print tables
P = function(table)
	return print(vim.inspect(table))
end

-- Checking if a package is loaded
_G.load_package = function(package_name)
	-- Status okay is a boolean
	local status_ok, package = pcall(require, package_name)
	return status_ok, package
end

-- Local keymap options
local default_opts = { noremap = true, silent = true }
-- Making global aliases for keymapping
_G.kmap = function(mode, lhs, rhs, opts)
	-- Setting our default options for our keypamp
	opts = opts or default_opts
	vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end
_G.bkmap = function(mode, lhs, rhs, opts, bufnr)
	opts = opts or default_opts
	-- setting default buffernumber
	bufnr = bufnr or 0
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
end

_G.get_filetype = function()
	return vim.fn.expand("%:e"):lower()
end

_G.is_filetype = function(filetypes)
	local ext = get_filetype()
	for _, target_ext in ipairs(filetypes) do
		if ext == target_ext:lower() then
			return true
		end
	end
	return false
end

_G.is_git_dir = function()
	-- Getting the output from term
	local file = io.popen("git rev-parse --show-toplevel 2>&1") or nil
	if not file then
		return false
	end
	local response = file:read("a")
	file:close()

	if string.find(response, "fatal:") then
		return false
	end
	return true
end

_G.has_key = function(table, val)
	for key, _ in pairs(table) do
		if key == val then
			return true
		end
	end
	return false
end

-- Simplifying setting options
_G.options_set = function(options, kind)
	if type(options) ~= "table" then
		error('options should be a type of "table"')
		return
	end
	kind = kind or "opt"
	for opt_key, opt_value in pairs(options) do
		vim[kind][opt_key] = opt_value
	end
end

_G.scandir = function(directory, exts)
	local file_list = vim.fn.split(vim.fn.system({ "ls", "-A", directory }))
	if exts then
		return file_list
	end
	return vim.fn.split(vim.fn.system({ "sed", [[s/\.[^.]*$//]] }, file_list))
end

_G.rerequire = function(module)
	assert(type(module) == "string", "`module` must be a string")
	package.loaded[module] = nil
	return require(module)
end
