local M = {}

local prettier = require("efmls-configs.formatters.prettier")

M.efm = function() return { prettier } end

return M
