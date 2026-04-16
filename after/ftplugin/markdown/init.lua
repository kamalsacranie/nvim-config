---@type table<[vim.bo], any>
local md_opts = {
    buf = {
        tabstop = 2,
        softtabstop = 2,
        shiftwidth = 0,
        expandtab = true,
        textwidth = 80,
    },
    win = {
        colorcolumn = "81"
    }
}

require("utils.spell")

local bufnr = vim.api.nvim_get_current_buf()
for opt, value in pairs(md_opts.buf) do
    vim.bo[bufnr][opt] = value
end
local winid = vim.api.nvim_get_current_win()
for opt, value in pairs(md_opts.win) do
    vim.wo[winid][opt] = value
end
