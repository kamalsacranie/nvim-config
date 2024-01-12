local M = {}

local black = function()
    local black = require("efmls-configs.formatters.black")

    ---@type table<string>
    local black_command = vim.fn.split(black.formatCommand, " ")
    table.insert(black_command, 2, "--line-length=79")

    black.formatCommand = table.concat(black_command, " ")
    return black
end
local flake8 = require("efmls-configs.linters.flake8")

M.efm = function()
    return { black(), flake8 }
end

return M
