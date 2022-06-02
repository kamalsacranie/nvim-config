local M = {}

M.is_git_dir = function()
	local file = io.popen("git rev-parse --show-toplevel 2>&1")
	local response = file:read("a")
	file:close()

	if string.find(response, "fatal:") then
		return false
	else
		return true
	end
end

return M

-- To add to create funcitonality which allows me to tell what files are in the
-- base directory. Can also create a funciton which checks what files are in
-- current directory. Coudl be useful
-- if [ -e renv ]
-- then
--     echo 1
-- else
--     echo 0
-- fi
