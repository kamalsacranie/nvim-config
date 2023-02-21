-- Should be broken out into a mappings thing
if is_git_dir() then
	vim.api.nvim_buf_set_keymap(
		0,
		"n",
		"<leader>rc",
		[[<CMD>call StartR("R")<CR><C-w>wa t<-getwd()<CR> setwd(system("git rev-parse --show-toplevel", intern=T))<CR> renv::activate()<CR> setwd(t)<CR>]],
		{ noremap = false, silent = true }
	)
	vim.api.nvim_buf_set_keymap(
		0,
		"n",
		"<leader>rr",
		"<leader>rc rmarkdown::render_site()<CR>",
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
	-- render using bookdown
	vim.api.nvim_buf_set_keymap(
		0,
		"n",
		"<leader>rr",
		[[<Cmd>w<CR><Cmd>TermExec direction='horizontal' cmd='bookdown-render.sh "%"' go_back=0<CR>]],
		{ noremap = true, silent = true }
	)
end
-- shift enter to run codeblock
vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<S-CR>",
	[[<localleader>cc]],
	{ noremap = false, silent = true }
)
