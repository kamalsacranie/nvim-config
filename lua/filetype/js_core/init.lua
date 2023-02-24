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
vim.schedule(function()
	options_set(M.buffer_options, "bo")
end)

vim.keymap.set(
	"n",
	"<leader><leader>t",
	require("filetype.js_core.jest_virt_text").test,
	{ buffer = true }
)

return M
