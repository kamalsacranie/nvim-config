local M = {}

M.efm = function()
    local stylua = require("efmls-configs.formatters.stylua")
    return { stylua }
end

return M
