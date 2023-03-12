local M = rerequire("filetype.markdown_core")

local ls = require("luasnip")
ls.filetype_extend("markdown", M.snippet_types)

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
