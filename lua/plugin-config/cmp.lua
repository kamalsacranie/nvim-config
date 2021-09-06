local cmp = require('cmp')

cmp.setup {
    -- Luasnip config
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end
    },

    mapping = {
        ['<Tab>'] = cmp.mapping.confirm({
            behaviour = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ['<CR>'] = cmp.mapping.scroll_docs(0)
    },

    formatting = {
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind]
                                .. " " .. vim_item.kind

            -- set a name for each source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]"
            })[entry.source.name]
            return vim_item
        end
    },

    sources = {
        {name = 'nvim_lsp'}, {name = "path"}, {name = 'luasnip'},
        {name = 'nvim_lua'}, {name = 'buffer'}
    },

    completion = {completeopt = 'menu,menuone,noinsert'}
}

require('nvim-autopairs.completion.cmp').setup({
    map_cr = true,
    map_complete = true,
    auto_select = true
})
