local M = {}

local jq = require("efmls-configs.formatters.jq")

M.efm = function()
    return { jq }
end

return M
