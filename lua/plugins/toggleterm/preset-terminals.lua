local M = {}

local Terminal = require("toggleterm.terminal").Terminal

M.lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

return M
