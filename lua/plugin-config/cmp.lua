local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        })
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
        {name = 'nvim_lsp'}, {name = "path"}, {name = 'ultisnips'},
        {name = 'nvim_lua'}, {name = 'buffer'}
    }
})

require("nvim-autopairs.completion.cmp").setup({
    -- map_cr = true, --  map <CR> on insert mode
    map_complete = true -- it will auto insert `(` after select function or method item
    -- auto_select = true -- automatically select the first item
})
