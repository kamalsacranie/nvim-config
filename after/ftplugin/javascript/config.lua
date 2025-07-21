local M = {}

local formatter = require("efmls-configs.formatters.prettier_d")

M.efm = function()
    return { formatter }
end

return M
