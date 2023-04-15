local M = {}
M.buffer_options = {
	-- Setting tabs,
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 0,
	expandtab = true,
	-- Setting width and colorcolumn,
	textwidth = 80,
}
-- Setting our options. If we were to have more anki specific options we would just do table.extend
vim.schedule(function()
	options_set(M.buffer_options, "bo")
end)
-- for some reason telescope likes to bring along this window option so i have
-- to set it manually
vim.cmd([[setlocal colorcolumn=81]])
vim.cmd([[setlocal wrap]])
vim.cmd([[setlocal linebreak]])

M.snippet_types = { "markdown_core" }

-- Causing issues with luasnip
-- local autopairs = require("nvim-autopairs")
-- autopairs.remove_rule("```")
-- autopairs.remove_rule("`")

require("utils.spell") -- Setting up spell
require("filetype.markdown_core.autocmds") -- no need to rerequire autcmds as nvim stores them
require("filetype.markdown_core.mappings")

vim.cmd([[nnoremap <expr> j v:count ? 'jzz' : 'gjzz']])
vim.cmd([[nnoremap <expr> k v:count ? 'kzz' : 'gkzz']])
vim.cmd([[vnoremap <expr> j v:count ? 'jzz' : 'gjzz']])
vim.cmd([[vnoremap <expr> k v:count ? 'kzz' : 'gkzz']])
vim.cmd([[nnoremap <expr> A v:count ? 'A' : 'g$a']])
vim.cmd([[nnoremap <expr> I v:count ? 'I' : 'g0i']])

return M
