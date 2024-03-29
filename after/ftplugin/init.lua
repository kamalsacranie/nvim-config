local utils = require("utils.helpers")
local defaults = {
    ensure_installed = { "markdown", "markdown_inline", "latex", "html" },
    indent = { enable = true },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    auto_install = true,
    ignore_install = {},
}

local setup = utils.get_items_in_directory(
    utils.get_path_of_lua_script() .. "/modules",
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
        ---@type table|nil
        local config = defaults
        for _, module_file_name in ipairs(data) do
            config = vim.tbl_deep_extend("force", config,
                {
                    [module_file_name] = require("plugins.treesitter.modules." ..
                        module_file_name)
                })
        end
        local ft_specific_config = get_table_from_ftplugin_filtype("treesitter")
        config = vim.tbl_deep_extend("force", config, ft_specific_config)
        require("nvim-treesitter.configs").setup(config or {})
        -- this likely needs to be changed to be done for every buffer so maybe put it in a aucmd
        vim.api.nvim_set_option_value("foldmethod", "expr",
            { win = 0, scope = "local" })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" },
            {
                group = vim.api.nvim_create_augroup("folding", { clear = true }),
                pattern = { "*" },
                callback = function()
                    vim.api.nvim_set_option_value("foldexpr",
                        "nvim_treesitter#foldexpr()",
                        { win = 0, scope = "local" })
                end
            })
    end)

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = setup,
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "hiphish/rainbow-delimiters.nvim",
        "nvim-treesitter/nvim-treesitter-textobjects"
    },
    enabled = true,
}
