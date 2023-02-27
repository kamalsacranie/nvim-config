local M = rerequire("filetype.markdown_core")

M.luasnip_config_extend = {
	ft_func = function()
		return { "markdown_core", "md" }
	end,
}

rerequire("filetype.md.mappings")

return M
