vim.keymap.set("n", "<leader>r", function()
	vim.cmd(
		[[:TermExec direction='horizontal' cmd='gcc -o "%:r.out" % && "./%:r.out"' go_back=0<CR>]]
	)
end)
