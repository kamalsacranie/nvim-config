local utils = require("nvim-mapper")

local setup = function()
    local ls = load_package("luasnip")
    if not ls then
        return
    end

    local ls_ft = require("luasnip.extras.filetype_functions")
    require("luasnip.loaders.from_lua").load({
        paths = {
            "./after/ftsnippets/lua",
        },
    })

    require("luasnip.loaders.from_vscode").lazy_load({
        paths = {
            vim.fn.stdpath("data") .. "/lazy/friendly-snippets",
        },
        override_priority = 999,
    })

    local defaults = {
        update_events = { "TextChanged", "TextChangedI" },
        keep_roots = true,
        link_roots = true,
        link_children = true,
        enable_autosnippets = true,
        ft_func = ls_ft.from_filetype,
    }
    utils.map_keymap_list(require("plugins.luasnip.mappings"))

    -- require("user.mappings.luasnip_map")
    -- ls.config.setup(extend_config(defaults, "luasnip_config_extend"))
    ls.config.setup(defaults)
end

return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    config = setup,
    event = { "InsertEnter" },
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" }
}
