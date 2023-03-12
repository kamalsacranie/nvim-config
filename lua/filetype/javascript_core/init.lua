local M = {}

M.buffer_options = {
	-- Setting tabs,
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 0,
	expandtab = true,
}
vim.schedule(function()
	options_set(M.buffer_options, "bo")
end)

M.snippet_types = { "javascript_core" }

vim.keymap.set(
	"n",
	"<leader><leader>t",
	require("filetype.javascript_core.jest_virt_text").test,
	{ buffer = true }
)

return M
