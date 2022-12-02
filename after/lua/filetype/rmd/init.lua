local M = rerequire("filetype.markdown_core")

require("filetype.rmd.autocmds")
require("filetype.rmd.mappings")

-- extending snippet filetypes from markdown_core. This happens in place
table.insert(M.snippet_types, "rmd")

M.luasnip_config_extend = {
	ft_func = function()
		return M.snippet_types
	end,
}

return M
