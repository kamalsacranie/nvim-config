local M = {}

local mapper = require("nvim-mapper")
local types = require("luasnip.util.types")
local ls_ft = require("luasnip.extras.filetype_functions")

local ext_opts = {
    [types.insertNode] = {
        -- these ext_opts are applied when the node is active (e.g. it has been
        -- jumped into, and not out yet).
        active = {
            -- highlight the text inside the node red.
            -- hl_group = "RedrawDebugRecompose"
        },
        -- these ext_opts are applied when the node is not active, but
        -- the snippet still is.
        passive = {
            -- add virtual text on the line of the node, behind all text.
            virt_text = { { "°", "Conceal" } }
        },
        -- visited or unvisited are applied when a node was/was not jumped into.
        visited = {
            -- hl_group = "RedrawDebugRecompose"
        },
        unvisited = {
            -- hl_group = "RedrawDebugRecompose"
        },
        -- and these are applied when both the node and the snippet are inactive.
        snippet_passive = {}
    }
}

M.setup = function()
    local ls = load_package("luasnip")
    if not ls then
        return
    end
    local defaults = {
        update_events = { "TextChanged", "TextChangedI" },
        keep_roots = true,
        link_roots = true,
        link_children = true,
        enable_autosnippets = true,
        ft_func = ls_ft.from_cursor_pos,
        snip_env = require("plugins.luasnip.snip_env_ext"),
        store_selection_keys = "<Tab>",
        loaders_store_source = true,
        ext_opts = ext_opts
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

return M
