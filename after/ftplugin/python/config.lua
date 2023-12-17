local M = {}

local black = require("efmls-configs.formatters.black")
local flake8 = require("efmls-configs.linters.flake8")
M.efm = { black, flake8 }

return M
