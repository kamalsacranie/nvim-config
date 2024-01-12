local M = {}

---@type table<number, Terminal>
M.exec_terms = {}

M.determine_term_direction = function()
    if vim.api.nvim_win_get_width(0) >= 100 then
        return "vertical"
    end
    return "horizontal"
end

local Terminal = require("toggleterm.terminal").Terminal
---@class Terminal
---@field try_open fun(self, size: number?, direction: string?)
function Terminal:try_open(size, direction)
    if not self:is_open() then
        self:open(size, direction)
    end
end

---Executesthe given cmd_if_new in an existing or new terminal. If
---cmd_if_exists is not given, no command will be executed in the existing
---terminal.
---@param cmd_if_new string
---@param bufnr number?
---@param cfg TermCreateArgs?
---@param cmd_if_exists string?
---@return Terminal?
M.exec_or_create_term = function(cmd_if_new, cfg, cmd_if_exists, bufnr)
    bufnr = vim.fn.bufnr() or bufnr
    local t = M.exec_terms[bufnr]
    if t then
        t:try_open()
        t:send(vim.api.nvim_replace_termcodes("<C-u>", true, false, true) ..
            (cmd_if_exists or ""))
        return
    end
    ---@type TermCreateArgs
    local default_config = {
        direction = M.determine_term_direction(),
        on_open = require("plugins.toggleterm.utils").map_term_nav_keys,
        on_exit = function()
            M.exec_terms[bufnr] = nil
        end,
    }
    local output_term = require("toggleterm.terminal").Terminal:new(vim
        .tbl_deep_extend("force", default_config, cfg or {}))
    M.exec_terms[bufnr] = output_term
    output_term:open()
    output_term:send(cmd_if_new)
    return output_term
end

return M
