-- Quality of life global functions
-- Defining some useful global functions we can use in command
-- mode

-- Making it easier to print tables
P = function(table)
    return print(vim.inspect(table))
end

-- Checking if a package is loaded
LOAD_PACKAGE = function(package_name)
    -- Status okay is a boolean
    local status_ok, package = pcall(require, package_name)
    return status_ok, package
end

-- Local keymap options
local default_opts = { noremap = true, silent = true }
-- Making global aliases for keymapping
KMAP = function(mode, lhs, rhs, opts)
    -- Setting our default options for our keypamp
    opts = opts or default_opts
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end
BKMAP = function(mode, lhs, rhs, opts, bufnr)
    opts = opts or default_opts
    -- setting default buffernumber
    bufnr = bufnr or 0
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
end

_G.is_git_dir = function()
    -- Getting the output from term
    local file = io.popen("git rev-parse --show-toplevel 2>&1")
    local response = file:read("a")
    file:close()

    if string.find(response, "fatal:") then
        return false
    end
    return true
end

_G.has_key = function(table, val)
    for key, _ in pairs(table) do
        if key == val then
            return true
        end
    end
    return false
end
