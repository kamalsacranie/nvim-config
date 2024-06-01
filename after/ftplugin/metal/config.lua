local M = {}

M.efm = function()
    return { require("efmls-configs.formatters.clang_format") }
end

return M
