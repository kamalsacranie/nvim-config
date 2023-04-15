local M = {}

if is_git_dir() then
	vim.api.nvim_buf_set_keymap(
		0,
		"n",
		"<leader>rc",
		[[<localleader>rf<C-w>wa t<-getwd()<CR> setwd(system("git rev-parse --show-toplevel", intern=T))<CR> renv::activate()<CR> setwd(t)<CR>]],
		{ noremap = false, silent = true }
	)
else
	-- start r consol
	vim.api.nvim_buf_set_keymap(
		0,
		"n",
		"<leader>rc",
		[[<localleader>rf]],
		{ noremap = false, silent = true }
	)
end

return M
