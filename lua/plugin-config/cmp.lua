local cmp = require('cmp')

cmp.setup {
    -- Luasnip config
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end
    },

    mapping = {['<Tab>'] = cmp.mapping.confirm({behaviour = cmp.ConfirmBehavior.Replace, select = true}), ['<CR>'] = cmp.mapping.scroll_docs(0)},

    formatting = {
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

            -- set a name for each source
            vim_item.menu =
                ({buffer = "[Buffer]", nvim_lsp = "[LSP]", luasnip = "[LuaSnip]", nvim_lua = "[Lua]", latex_symbols = "[Latex]"})[entry.source.name]
            return vim_item
        end
    },

    sources = {{name = 'nvim_lsp'}, {name = "path"}, {name = 'luasnip'}, {name = 'nvim_lua'}, {name = 'buffer'}},

    completion = {completeopt = 'menu,menuone,noinsert'}
}

require('nvim-autopairs.completion.cmp').setup({map_cr = true, map_complete = true, auto_select = true})

local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

-- vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<Leader>de', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'pd', '<cmd>lua peek_definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>', opts)
-- vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>', opts)
-- vim.api.nvim_set_keymap('n', '[D', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
-- vim.api.nvim_set_keymap('n', ']D', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'do', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
