require("utils.markdown-core")

-- Using treesitter for our parser
local is_loaded, ts_parser = load_package("nvim-treesitter.parsers")
if is_loaded then
	local ft_to_parser =
		require("nvim-treesitter.parsers").filetype_to_parsername
	ft_to_parser.anki = "markdown"
end

vim.cmd([[augroup snippets
	autocmd!
	autocmd BufEnter * exec ":UltiSnipsAddFiletypes anki.markdown-core.markdown"
augroup END]])
