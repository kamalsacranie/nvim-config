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

return M
