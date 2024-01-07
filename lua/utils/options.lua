local M = {}

---@class opts
---@field buf vim.bo
---@field win vim.wo

---@param default_opts vim.api.keyset.option
---@return fun(key: string, value: any, opts?: vim.api.keyset.option)
local set_option_value_with_defaults = function(default_opts)
    return function(key, value, opts)
        vim.api.nvim_set_option_value(key, value,
            vim.tbl_deep_extend("force", default_opts, opts or {}) or {})
    end
end

---Sets options locally by default
---@param buf_options vim.bo
---@param opts? vim.api.keyset.option
M.set_buf_options = function(buf_options, opts)
    for key, value in pairs(buf_options) do
        set_option_value_with_defaults({ buf = vim.fn.bufnr() })(
            key, value, opts)
    end
end


---Sets options locally by default
---@param win_options vim.wo
---@param opts? vim.api.keyset.option
M.set_window_options = function(win_options, opts)
    for key, value in pairs(win_options) do
        set_option_value_with_defaults({
            win = vim.fn
                .win_getid(),
            scope = "local"
        })(key, value, opts)
    end
end

---Batch set options table. Both window and buffer set with local as default
---@param options opts
---@param buf_opts? vim.api.keyset.option
---@param win_opts? vim.api.keyset.option
M.set_all_options = function(options, buf_opts, win_opts)
    if options.buf ~= nil then M.set_buf_options(options.buf, buf_opts) end
    if options.win ~= nil then M.set_window_options(options.win, win_opts) end
end

return M
