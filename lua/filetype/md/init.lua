local M = rerequire("filetype.markdown_core")

M.luasnip_config_extend = {
	ft_func = function()
		return { "markdown_core", "md" }
	end,
}

rerequire("filetype.md.mappings")

-- -- on write formatting
-- local markdown_write_augroup =
-- 	vim.api.nvim_create_augroup("markdown_write", { clear = false })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	group = markdown_write_augroup,
-- 	pattern = { "*.md", "*.qmd" },
-- 	callback = function()
-- 		vim.cmd([[FormatWrite]])
-- 	end,
-- })

return M
