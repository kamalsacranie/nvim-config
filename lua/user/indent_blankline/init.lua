local ib_did_load, indent_blankline = load_package("indent_blankline")
if not ib_did_load then
	return
end

-- Highlights for regular linechar
vim.cmd([[highlight IndentBlanklineIndent guifg=#3b305c gui=nocombine]])
-- Hgihlights for context linechar
vim.cmd([[highlight IndentBlanklineContextChar guifg=#751e26 gui=nocombine]])

indent_blankline.setup({
	char = "┃",
	char_blankline = "┆",
	char_highlight_list = { "IndentBlanklineIndent" },
	show_current_context = true,
	use_treesitter = true,
	show_trailing_blankline_indent = false,
	bufname_excludes = { [[.*\.md]], [[.*\.rmd]], [[.*\.Rmd]], [[.*\.anki]] },
	-- use_treesitter_scope = true,
})
