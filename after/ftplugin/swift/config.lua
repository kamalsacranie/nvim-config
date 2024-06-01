local M = {}

M.efm = function()
    ---@type table<table>
    local efm_config = {}

    local cwd = vim.fn.getcwd()
    local result = vim.fs.find({ ".swift-format" },
        {
            upward = true,
            path = cwd
        })
    if vim.fn.executable("swift-format") then
        table.insert(efm_config, {
            formatCommand = "swift-format format " ..
                (#result > 0 and " --configuration " .. result[1] or ""),
            formatStdin = true,
        })
    end
    return efm_config
end

return M
