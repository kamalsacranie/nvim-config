local utils = require("utils.helpers")
local defaults = {
    ensure_installed = "all",
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    auto_install = true,
    ignore_install = {},
}

local setup = utils.get_items_in_directory(utils.get_path_of_lua_script() .. "modules",
    function()
        require "nvim-treesitter.configs".setup(defaults)
    end,
    function(data)
        data = vim.tbl_map(function(entry)
            entry = entry[1]
            if entry.type == "file" then
                return vim.fn.split(entry.name, [[\.]])[1]
            end
        end, data)
        local config = defaults
        for _, module_file_name in ipairs(data) do
            config = vim.tbl_deep_extend("force", defaults,
                { [module_file_name] = require("plugins.treesitter.modules." .. module_file_name) })
        end
        require "nvim-treesitter.configs".setup(config)
    end)

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = setup,
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring", "hiphish/rainbow-delimiters.nvim" },
    enabled = true,
}
