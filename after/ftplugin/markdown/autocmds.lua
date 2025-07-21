-- This file gets required somewhere but idk where. It's quite weird. Probably
-- something to do with how I load my filetype config files
local md_aucmd_group = vim.api.nvim_create_augroup("markdown", { clear = true })

vim.api.nvim_create_autocmd(
    { "BufEnter" }, {
        callback = function()
            vim.cmd [[TSDisable indent]]
        end,
        group = md_aucmd_group,
        desc = "Handles changing settings when entering a markdown buffer"
    }
)

vim.api.nvim_create_autocmd(
    { "BufLeave" }, {
        callback = function()
            vim.cmd [[TSEnable indent]]
        end,
        group = md_aucmd_group,
        desc = "Handles changing settings when entering a markdown buffer"
    }
)
