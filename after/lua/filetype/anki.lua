-- Our core file returns a table with shared markdown options
local M = rerequire("filetype.markdown_core")

-- Using treesitter for our parser
local is_loaded, ts_parser = load_package("nvim-treesitter.parsers")
if is_loaded then
	local ft_to_parser = ts_parser.filetype_to_parsername
	ft_to_parser.anki = "markdown"
end

-- Setting our cliboard image paste functions
M.clipboard_image = {
	img_dir = function()
		return "."
	end,
	img_dir_txt = function()
		return "."
	end,
}

return M
