local M = rerequire("filetype.markdown_core")

-- Having trouble with UltiSnips pointing twice to the same file. Been a while
-- since I've had a look at my nvim cfg so looks like I'm going to have to
-- search throught the weeds
-- vim.cmd([[augroup rmarkdown
--   autocmd!
--   " filetypes must be this way round for some reason
--   autocmd BufEnter * exec ":UltiSnipsAddFiletypes rmarkdown"
-- augroup END]])
require("filetype.rmd.autocmds")

-- Should be broken out into a mappings thing
if is_git_dir() then
	-- deprecated papis command, replaced by cmp
	-- vim.api.nvim_buf_set_keymap(
	-- 	0,
	-- 	"n",
	-- 	"<leader>rb",
	-- 	[[<Cmd>w<CR><Cmd>silent! TermExec direction='float' cmd='cd $(git rev-parse --show-toplevel); papis list --format "@{doc[ref]}" | pbcopy; exit'<CR>]],
	-- 	{ noremap = true, silent = true }
	-- )
	-- Sets the cwd as and starts the correct venv (hopefully it just silently
	-- fails when there is no git)
	vim.api.nvim_buf_set_keymap(
		0,
		"n",
		"<leader>rc",
		[[<localleader>rf<C-w>wa t<-getwd()<CR> setwd(system("git rev-parse --show-toplevel", intern=T))<CR> renv::activate()<CR> setwd(t)<CR>]],
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
return M
