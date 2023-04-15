local M = {}

local buffer_options = {
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
	options_set(buffer_options, "bo")
end)

return M
