vim.keymap.set("n", "<leader>r", function()
	vim.cmd(
		[[:TermExec direction='horizontal' cmd='gcc % && ./a.out' go_back=0<CR>]]
	)
end)
