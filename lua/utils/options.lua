local M = {}

---@class opts
---@field buf vim.bo
---@field win vim.wo
---@field glob vim.bo

---@param default_opts vim.api.keyset.option
---@return fun(key: string, value: any, opts?: vim.api.keyset.option)
local set_opt_with_defaults = function(default_opts)
    return function(key, value, opts)
        vim.api.nvim_set_option_value(key, value,
            vim.tbl_deep_extend("force", default_opts, opts or {}) or {})
    end
end

--- Returns a function which sets all options with a given setting function. If
--- no setting function is given, vim.api.nvim_set_option_value is used.
---@param options vim.bo | vim.wo
---@param setting_func? fun(key: string, value: any, opts?: vim.api.keyset.option)
---@return fun(opts?: vim.api.keyset.option)
M.batch_set_options = function(options, setting_func)
    setting_func = setting_func or vim.api.nvim_set_option_value
    return function(opts)
        for key, value in pairs(options) do
            setting_func(key, value, opts or {})
        end
    end
end

---Sets options locally by default
---@param buf_options vim.bo
---@param opts? vim.api.keyset.option
M.set_buf_options = function(buf_options, opts)
    local option_setter = M.batch_set_options(buf_options,
        set_opt_with_defaults({ buf = vim.fn.bufnr() }))
    option_setter(opts)
end


---Sets options locally by default
---@param win_options vim.wo
---@param opts? vim.api.keyset.option
M.set_window_options = function(win_options, opts)
    local options_setter = M.batch_set_options(win_options,
        set_opt_with_defaults({
            win = vim.fn
                .win_getid(),
            scope = "local"
        }))
    options_setter(opts)
end

---@param global_options vim.bo
---@param opts? vim.api.keyset.option
M.set_global_options = function(global_options, opts)
    local options_setter = M.batch_set_options(global_options)
    options_setter(opts)
end

---Batch set options table. Both window and buffer set with local as default
---@class all_setting_options
---@field buf? vim.api.keyset.option
---@field win? vim.api.keyset.option
---@field glob? vim.api.keyset.option
---@param options opts
---@param setting_options? all_setting_options
M.set_all_options = function(options, setting_options)
    setting_options = setting_options or {}
    if options.buf ~= nil then
        M.set_buf_options(options.buf, setting_options
            .buf)
    end
    if options.win ~= nil then
        M.set_window_options(options.win,
            setting_options.win)
    end
    if options.glob ~= nil then
        M.set_global_options(options.glob,
            setting_options.glob)
    end
end

return M
