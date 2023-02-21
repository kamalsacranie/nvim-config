local M = rerequire("filetype.markdown_core")

require("filetype.rmd.autocmds")
rerequire("filetype.rmd.mappings")

-- Adding rmd ft snippets
table.insert(M.snippet_types, "rmd")

M.luasnip_config_extend = {
	ft_func = function()
		return M.snippet_types
	end,
}

vim.cmd("let R_set_omnifunc = []")
vim.cmd("let R_auto_omni = []")

return M
