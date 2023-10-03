vim.keymap.set("n", "<leader>r", function()
	-- Run subprocess command and capture output to see if we are in a poetry environment
	local handle = io.popen("poetry show -v | head -n 1 | sed 's/^.*://g'")
	local output = handle:read("*a")
	handle:close()
	output = output:gsub("^%s*(.-)%s*$", "%1")

	-- Check if output matches absolute file path regex
	if string.match(output, "^/.*") then
		vim.cmd([[:w]])
		vim.cmd(
			[[:TermExec direction='horizontal' cmd='source ]]
				.. output
				.. [[/bin/activate; python3 %' go_back=0<CR>"]]
		)
	else
		-- needs to be heavilty refactored
		local handle = io.popen("poetry show -v | head -n 1 | sed 's/^.*://g'")
		local output = handle:read("*a")
		handle:close()
		if string.match(output, "^/.*") then
			vim.cmd([[:w]])
			vim.cmd(
				[[:TermExec direction='horizontal' cmd='source $VIRTUAL_ENV/bin/activate; python3 %' go_back=0<CR>]]
			)
		else
			vim.cmd([[:w]])
			vim.cmd(
				[[:TermExec direction='horizontal' cmd='python3 %' go_back=0<CR>]]
			)
		end
	end
end)
