local mapper = require("nvim-mapper")

local setup = function()
    local ls = load_package("luasnip")
    if not ls then
        return
    end
    local ls_ft = require("luasnip.extras.filetype_functions")
    local defaults = {
        update_events = { "TextChanged", "TextChangedI" },
        keep_roots = true,
        link_roots = true,
        link_children = true,
        enable_autosnippets = true,
        ft_func = ls_ft.from_cursor_pos,
        snip_env = require("plugins.luasnip.snip_env_ext"),
    }
    mapper.map_keymap_list(require("plugins.luasnip.mappings"))

    local config = vim.tbl_deep_extend("force", defaults,
        get_table_from_ftplugin_filtype("luasnip"))
    ls.config.setup(config)
    require("luasnip.loaders.from_lua").load({
        paths = {
            "./after/ftsnippets/lua",
        },
        override_priority = 999,
    })
    require("luasnip.loaders.from_vscode").lazy_load({
        paths = {
            vim.fn.stdpath("data") .. "/lazy/friendly-snippets",
        },
        override_priority = 998,
    })
end

return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    event = "InsertEnter",
    config = setup,
    build = "make install_jsregexp",
    dependencies = { { "rafamadriz/friendly-snippets" }, { "nvim-treesitter/nvim-treesitter" } }
}
