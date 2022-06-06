-- Setting tabs
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 0
vim.opt_local.expandtab = true
-- Setting width and colorcolumn
vim.opt.textwidth = 80
vim.wo.colorcolumn = "81"

-- Setting up spell
require("utils.spell")

local is_markdown_file = function(lang, bufnr)
	local is_ft = function(ft)
		return string.find(vim.api.nvim_buf_get_option(bufnr, "ft"), ft)
	end
	if is_ft("markdown") or is_ft("rmd") then
		return true
	end
end

local treesitter_did_load, ts_config = load_package("nvim-treesitter.configs")
if treesitter_did_load then
	ts_config.setup({
		highlight = {
			disable = is_markdown_file,
			additional_vim_regex_highlighting = is_markdown_file,
		},
	})
end

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
	[[<Cmd>TOC<CR>]],
	{ noremap = true, silent = true }
)

-- Tablemode settings
vim.cmd([[let g:table_mode_corner_corner='+']])
vim.cmd([[let b:table_mode_corner='+']])
vim.cmd([[let g:table_mode_header_fillchar='=']])
-- folding
vim.cmd([[
function MarkdownLevel()
    let h = matchstr(getline(v:lnum), '^#\+ ')
    if empty(h)
        return "="
    else
        return ">" . len(h)
endif
endfunction
augroup md_fold
    au!
    au BufEnter * setlocal foldexpr=MarkdownLevel() 
augroup END
]])

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
