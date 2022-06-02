local M = {}

-- Test if directory is a git directory
M.is_git_dir = function()
	-- Getting the output from term
	local file = io.popen("git rev-parse --show-toplevel 2>&1")
	local response = file:read("a")
	file:close()

	if string.find(response, "fatal:") then
		return false
	end
	return true
end

return M
