-- -- Quality of life global functions
-- -- Defining some useful global functions we can use

-- -- Local keymap options
-- local default_opts = { noremap = true, silent = true }

-- Making it easier to print tables
---@param ... table | string | nil | boolean | integer | function
---@return nil
_G.P = function(...)
    local result = {}
    for i = 1, select("#", ...) do
        local arg = select(i, ...)
        if arg == nil then
            arg = "nil"
        end
        table.insert(result, type(arg) == "table" and vim.inspect(arg) or arg)
    end
    print(unpack(result))
end


-- Checking if a package is loaded
---comment
---@param package_name string
---@return table | nil
_G.load_package = function(package_name)
    -- Status okay is a boolean
    local status, module = pcall(require, package_name)
    if not status then
        return nil
    end
    return module
end

--- Returns the secified table from the export of after/ftplugin/{filetype}/config.lua
---@param filetype string?
_G.get_table_from_ftplugin_filtype = function(config_table_name, filetype)
    local ft = filetype or vim.filetype.match({ buf = 0 }) or
        vim.fn.expand("%:e")
    local reqpath = "ftplugin" .. "." .. ft .. ".config"

    if type(package.loaded[reqpath]) == table then -- sometimes it can be a tiny random number
        local cfg = package.loaded[reqpath][config_table_name]
        if type(cfg) == "function" then cfg = cfg() end
        return cfg
    end

    package.loaded[reqpath] = nil -- things can get confusing fi we dont reset this package

    local success, ftplugin = pcall(require,
        "ftplugin" .. "." .. ft .. ".config")
    local cfg = ftplugin[config_table_name]
    if type(cfg) == "function" then cfg = cfg() end
    return (success and type(ftplugin) == "table") and
        cfg or {}
end
