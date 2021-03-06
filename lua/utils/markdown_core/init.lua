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

M.ts_config = { -- Treesitter settings
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
}
-- Setting our options. If we were to have more anki specific options we would just do table.extend
options_set(M.buffer_options, "bo")
-- for some reason telescope likes to bring along this window option so i have
-- to set it manually
vim.cmd([[setlocal colorcolumn=81]])

local autopairs = require("nvim-autopairs")
autopairs.remove_rule("```")
autopairs.remove_rule("`")

rerequire("utils.spell") -- Setting up spell
require("utils.markdown_core.autocmds") -- no need to rerequire autcmds as nvim stores them
rerequire("utils.markdown_core.mappings")

return M
