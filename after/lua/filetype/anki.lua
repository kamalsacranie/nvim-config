require("utils.markdown_core")

local M = {}

-- Using treesitter for our parser
local is_loaded, ts_parser = load_package("nvim-treesitter.parsers")
if is_loaded then
	local ft_to_parser = ts_parser.filetype_to_parsername
	ft_to_parser.anki = "markdown"
end

vim.cmd([[augroup snippets
	autocmd!
	autocmd BufEnter * exec ":UltiSnipsAddFiletypes anki.markdown-core.markdown"
augroup END]])

M.clipboard_image = {
	-- Create folder called assets and then a subfolder using the current
	-- file name without the file extension
	img_dir = function()
		return "."
	end,
	img_dir_txt = function()
		return "."
	end,
}

return M
