local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

-- local md_cleanup = create_augroup("md_cleanup", { clear = true })
-- create_autocmd("BufEnter", {
-- 	group = md_cleanup,
-- 	callback = function()
-- 		vim.cmd([[UltiSnipsAddFiletypes markdown]])
-- 	end,
-- 	pattern = "*.md, *.markdown",
-- 	desc = "Markdown cleanup when we go into buffer",
-- })
