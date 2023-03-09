local M = {}

--- Recursively walk up the file system until a directory is reached
--- which contains a file/folder with th given filename
---@param dir string the directory in which you want the search to start
---@param file_name string file you want to match in a parent directory
---@return string | nil, string?) the root directory and the full filepath to the matched file or nil
M.root_directory_from_pattern = function(dir, file_name)
	local file_path = dir .. "/" .. file_name
	local open_file = io.open(file_path, "r")

	if open_file then
		open_file:close()
		return dir, file_path
	end

	local parent_dir = dir:match("(.+)/[^/]+")

	if parent_dir then
		return M.root_directory_from_pattern(parent_dir, file_name)
	end
	return nil
end

return M
