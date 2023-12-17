local M = {}

M.determine_term_direction = function()
    if vim.api.nvim_win_get_width(0) >= 100 then
        return "vertical"
    end
    return "horizontal"
end

return M
