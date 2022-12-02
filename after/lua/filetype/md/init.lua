local M = rerequire("filetype.markdown_core")

M.luasnip_config_extend = {
	ft_func = function()
		return { "markdown_core", "md" }
	end,
}

require("filetype.md.autocmds") -- no need to re-require autocmds as nvim stores them
rerequire("filetype.md.mappings")

return M
