--[[ We have to use the global re-require function here because of the special
--way lua handles requires and how we are structuring our filetypes. nvim only
--properly rerequires this file so we have rerequire subsequent requres ]]
--[[ What we could do is pass thorugh keymaps, etc in the returns and then set
--them up inside here, i.e. map the keymaps etc, seems less elegant as we will
--be doing it more than once for our markdown, rmarkdown, and anki files. We
--could pass functions throught and then call them here, but again, not as
--optimal i don't think??]]
-- The rerequire seems to have a performance overhead... Perhaps it is better
-- to send back functions
-- rerequire("filetype.anki")
-- Our core file returns a table with shared markdown options
local M = require("filetype.markdown_core")

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
