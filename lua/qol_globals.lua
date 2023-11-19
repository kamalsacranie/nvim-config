-- Quality of life global functions
-- Defining some useful global functions we can use

-- Local keymap options
local default_opts = { noremap = true, silent = true }

-- Making it easier to print tables
---@param ... table | string | nil | boolean | integer | function
---@return nil
_G.P = function(...)
    local inputs = { ... }
    inputs = vim.tbl_map(function(input)
        return type(input) == "table" and print(vim.inspect(input))
            or print(input)
    end, inputs)
    print(unpack(inputs))
end

--- Maps a function to a list-like table
---@param tbl table
---@param f function which takes one parameter which is the element
---@return table
_G.tbl_kvp_map = function(f, tbl)
    local t = {}
    for k, v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end

---@param tbl table
---@param f function which takes one parameter which is the element
---@return table
_G.filter = function(tbl, f, list_like)
    list_like = list_like or true
    local t = {}
    for k, v in pairs(tbl) do
        if f(v) then
            if list_like then
                table.insert(t, v)
            else
                t[k] = v
            end
        end
    end
    return t
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

-- Making global aliases for keymapping
_G.kmap = function(mode, lhs, rhs, opts)
    -- Setting our default options for our keypamp
    opts = opts or default_opts
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

---Less verbose key mapping
---@param mode string String for which mode you want the map in
---@param lhs string The keys you want to remap
---@param rhs string The action you want to remap to
---@param opts table|nil
---@param bufnr integer|nil
_G.bkmap = function(mode, lhs, rhs, opts, bufnr)
    opts = opts or default_opts
    -- setting default buffernumber
    bufnr = bufnr or 0
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
end

--- Returns the file extension of a file without the leading "." in lowercase
---@return string
_G.get_filetype = function()
    return vim.fn.expand("%:e"):lower()
end

--- Check if a file has an extension specified in a passed in table
---@param filetypes string[]
---@return boolean
_G.is_filetype = function(filetypes)
    local ext = get_filetype()
    for _, target_ext in ipairs(filetypes) do
        if ext == target_ext:lower() then
            return true
        end
    end
    return false
end

_G.shell_command = function(command)
    local file = io.popen(command) or nil
    if not file then
        return false
    end
    local response = file:read("a")
    file:close()
    return response
end

--- Checks if a table contains a given key using the vim.fn.has_key(table, string) function
---@param table table<string, any> A non list like table
---@param key string A key to find within the table
---@return boolean
_G.has_key = function(table, key)
    return vim.fn.has_key(table, key) ~= 0 and true or false
end

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

--- Scan a directory for the files within and return a list of those files
---@param directory string directory to scan
---@param exts? string extension to look for
---@return Array of file names
_G.scandir = function(directory, exts)
    local file_list = vim.fn.split(vim.fn.system({ "ls", "-A", directory }))
    if exts then
        return file_list
    end
    return vim.fn.split(vim.fn.system({ "sed", [[s/\.[^.]*$//]] }, file_list))
end

--- Reload a package from scratch
---@param module string Module name
---@return unknown
_G.rerequire = function(module)
    assert(type(module) == "string", "`module` must be a string")
    package.loaded[module] = nil
    return require(module)
end

-- Dynamically generating opts based on what is in our ftplugin file to reduce coupling with ts
---@param config_table_name string
---@param config_defaults table|nil
---@return table
_G.extend_config = function(config_defaults, config_table_name)
    ---@return table
    local get_filetype_opts = function()
        local ft = vim.bo.filetype
        local success, ftplugin = pcall(require, "filetypes" .. "." .. ft)
        if success and type(ftplugin) == "table" then
            return ftplugin[config_table_name]
        end
        return {}
    end
    local generate_options = function(filetype_opts)
        return vim.tbl_extend(
            "force",
            config_defaults or {},
            filetype_opts or {}
        )
    end

    local filetype_opts = get_filetype_opts()
    return generate_options(filetype_opts)
end

--------- Temp because luasnip snipenv dont work
_G.lsg = {
    visual = function()
        -- returns a function snippet which returns the current visual selection
        local f = require("luasnip").f
        return f(function(_, snip)
            local visual = snip.env.LS_SELECT_RAW
            if type(visual) == "string" then
                return ""
            end
            return visual
        end)
    end,
    midword = function(conf, nodes)
        -- Returns a snippet which expands mid line
        local s = require("luasnip").s
        local f = require("luasnip").f
        return s(
            vim.tbl_extend(
                "keep",
                { trig = "(.*)" .. conf["trig"], regTrig = true },
                conf
            ),
            vim.list_extend(
                { f(function(_, snip)
                    return snip.captures[1]
                end) },
                nodes
            )
        )
    end,
}
