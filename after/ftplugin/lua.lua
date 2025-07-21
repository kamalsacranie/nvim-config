local M = {}

local stylua = require("efmls-configs.formatters.stylua")

M.efm = function()
    return { stylua }
end

return M
