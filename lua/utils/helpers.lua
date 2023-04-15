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

--- Checks if we are in a git repo
---@return boolean
M.is_git_repo = function()
	local bufnr = vim.fn.bufnr()
	local dir, _ = M.root_directory_from_pattern(vim.fn.getcwd(bufnr), ".git")
	if dir then
		return true
	end
	return false
end

return M
