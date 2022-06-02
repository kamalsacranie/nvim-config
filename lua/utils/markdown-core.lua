-- Setting tabs
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 0
vim.opt_local.expandtab = true
-- Setting width and colorcolumn
vim.opt_local.textwidth = 79
vim.wo.colorcolumn = "80"

-- Setting up spell
require("utils.spell")

-- Keymaps
vim.api.nvim_set_keymap("n", "gf", "gf<C-w>o", { noremap = true })
vim.g["pandoc#hypertext#split_open_cmd"] = "e"

-- require'clipboard-image'.setup {require('plugin-config/clipboard-image')}

-- Disabling tick autopair surely there has to be a better way to do this
-- not in the ftplugin idk
require("nvim-autopairs").remove_rule("```")
require("nvim-autopairs").remove_rule("`")

-- Generate toc in quickfix list
vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<leader>toc",
	-- [[<Cmd>vimgrep '^\#' % | cw<CR>]],
	[[<Cmd>TOC<CR>]],
	{ noremap = true, silent = true }
)

-- Tablemode settings
vim.cmd([[let g:table_mode_corner_corner='+']])
vim.cmd([[let b:table_mode_corner='+']])
vim.cmd([[let g:table_mode_header_fillchar='=']])

vim.api.nvim_buf_set_keymap(
	0,
	"v",
	"<leader>rp",
	[[y:! qlmanage -p '<C-R>"'<CR><CR>]],
	{ noremap = false, silent = true }
)
-- Latex image render script in user bin
vim.api.nvim_buf_set_keymap(
	0,
	"v",
	"<leader>lr",
	[[y:! lateximg '<C-R>"'<CR><CR>]],
	{ noremap = false, silent = true }
)
vim.api.nvim_buf_set_keymap(
	0,
	"v",
	"<leader>lmr",
	[[y:! lateximg '\begin{align*}<C-R>"\end{align*}'<CR><CR>]],
	{ noremap = false, silent = true }
)

vim.cmd([[augroup snippets
	autocmd!
	autocmd VimEnter * exec ":UltiSnipsAddFiletypes markdown-core"
augroup END]])
