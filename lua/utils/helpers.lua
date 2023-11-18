local M = {}

--- Recursively walk up the file system until a directory is reached
--- which contains a file/folder with th given filename
---@param dir string the directory in which you want the search to start
---@param file_name string file you want to match in a parent directory
---@return string | nil) the root directory with no trailing slash if it exists
M.root_directory_from_pattern = function(dir, file_name)
	local file_path = dir .. "/" .. file_name
	local open_file = io.open(file_path, "r")

	if open_file then
		open_file:close()
		return dir
	end

	local parent_dir = dir:match("(.+)/[^/]+")

	if parent_dir then
		return M.root_directory_from_pattern(parent_dir, file_name)
	end
	return nil
end

--- Returns the current buffer directory or nil
---@return string | nil
M.current_buffer_dir = function()
	local bufnr = vim.fn.bufnr()
	return vim.fn.bufexists(bufnr) == 1 and vim.fn.getcwd(bufnr) or nil
end

--- Checks if we are in a git repo
---@return boolean
M.is_git_repo = function()
	local cd = M.current_buffer_dir()
	if not cd then
		return false
	end
	local dir = M.root_directory_from_pattern(cd, ".git")
	if dir then
		return true
	end
	return false
end

--- Revers a list-like table
---@param list List
---@return List
M.reverse_list_table = function(list)
	local len = #list
	local result = vim.deepcopy(list)
	for i = 1, math.floor(len / 2) do
		result[i], result[len - i + 1] = result[len - i + 1], result[i]
	end
	return result
end


----- Coordinate structure
---@class Keymap
---@field mode string
---@field left string
---@field right string | function
---@field opts table?
---@param mappings table
---@param ext_opts table?
---@param callback function?
---@return nil
M.map_keymap_list = function(mappings, ext_opts, callback)
    ext_opts = ext_opts or {}
    vim.tbl_map(function(mapping)
        local mode, left, right, opts = unpack(mapping)
        local rhs;
        if callback then
            if type(right) == "string" then
                print("Cannot provide callback when right hand side of keymap is string")
            end
            rhs = function()
                callback(right)
            end
        else
            rhs = right
        end
        vim.keymap.set(mode, left, rhs, vim.tbl_deep_extend("keep", opts or {}, ext_opts))
    end, mappings)
end

return M
