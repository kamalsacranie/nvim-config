vim.api.nvim_set_keymap(
	"n",
	"n",
	"<Plug>(highlight-current-n-n)",
	{ noremap = false }
)
vim.api.nvim_set_keymap(
	"n",
	"N",
	"<Plug>(highlight-current-n-N)",
	{ noremap = false }
)
vim.cmd([[
augroup ClearSearchHL
  autocmd!
  " You may only want to see hlsearch /while/ searching, you can automatically
  " toggle hlsearch with the following autocommands
  autocmd CmdlineEnter /,\? set hlsearch
  autocmd CmdlineLeave /,\? set nohlsearch
  " this will apply similar n|N highlighting to the first search result
  " careful with escaping ? in lua, you may need \\?
  autocmd CmdlineLeave /,\? lua require('highlight_current_n')['/,?']()
augroup END
]])
