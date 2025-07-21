local M = {}

local flake8 = require("efmls-configs.linters.flake8")

M.efm = function()
    return { flake8 }
end

return M
