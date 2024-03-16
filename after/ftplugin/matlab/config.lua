local M = {}

M.efm = function()
    return {
        {
            formatCommand = "matlab_formatter",
            formatStdin = false
        }
    }
end

return M
