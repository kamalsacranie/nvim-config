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

-- _G.shell_command = function(command)
--     local file = io.popen(command) or nil
--     if not file then
--         return false
--     end
--     local response = file:read("a")
--     file:close()
--     return response
-- end

-- --- Checks if a table contains a given key using the vim.fn.has_key(table, string) function
-- ---@param table table<string, any> A non list like table
-- ---@param key string A key to find within the table
-- ---@return boolean
-- _G.has_key = function(table, key)
--     return vim.fn.has_key(table, key) ~= 0 and true or false
-- end

--- Set a table of the same kind of options ("opt", "bo", "wo") all at once
---@param options table<string, any>
---@param kind string|nil a choice of "opt" | "bo" | "wo" | "go">
_G.options_set = function(options, kind)
    if type(options) ~= "table" then
        error('options should be a type of "table"')
        return
    end
    kind = kind or "opt"
    for opt_key, opt_value in pairs(options) do
        vim[kind][opt_key] = opt_value
    end
end

-- --- Scan a directory for the files within and return a list of those files
-- ---@param directory string directory to scan
-- ---@param exts? string extension to look for
-- ---@return Array of file names
-- _G.scandir = function(directory, exts)
--     local file_list = vim.fn.split(vim.fn.system({ "ls", "-A", directory }))
--     if exts then
--         return file_list
--     end
--     return vim.fn.split(vim.fn.system({ "sed", [[s/\.[^.]*$//]] }, file_list))
-- end

-- --- Reload a package from scratch
-- ---@param module string Module name
-- ---@return unknown
-- _G.rerequire = function(module)
--     assert(type(module) == "string", "`module` must be a string")
--     package.loaded[module] = nil
--     return require(module)
-- end

--- Returns the secified table from the export of after/ftplugin/{filetyp}
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
