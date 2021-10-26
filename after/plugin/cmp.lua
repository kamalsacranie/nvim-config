local cmp = require('cmp')
-- Information icons with our completions
-- Custom icons so we dont have to use a different plugin

local icons = {
    Class = " ",
    Color = " ",
    Constant = "ﲀ ",
    Constructor = " ",
    Enum = "練",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = "",
    Folder = " ",
    Function = " ",
    Interface = "ﰮ ",
    Keyword = " ",
    Method = "⦿ ",
    Module = " ",
    Operator = "",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = "塞",
    Value = " ",
    Variable = " "
}

-- Look if there is text behind us i think
-- local check_backspace = function()
--     local col = vim.fn.col "." - 1
--     return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- end
-- Replace termcodes when we feed keys
-- local function t(str)
--     return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end

cmp.setup({

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = icons[vim_item.kind]
            -- setting up our won icons etc
            vim_item.menu = ({
                nvim_lsp = "「LSP",
                emoji = "「Emoji",
                path = "「Path",
                calc = "「Calc",
                cmp_tabnine = "「Tabnine",
                ultisnips = "「Snippet",
                buffer = "「Buffer"
            })[entry.source.name]
            vim_item.dup = ({buffer = 1, path = 1, nvim_lsp = 0})[entry.source
                               .name] or 0
            return vim_item
        end
    },

    snippet = {
        expand = function(args)
            vim.fn['UltiSnips#Anon'](args.body)
        end
    },

    sources = {
        {name = 'nvim_lsp'}, {name = 'path'}, {name = 'nvim_lua'},
        {name = 'ultisnips'}
    },

    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-Space>'] = cmp.mapping.confirm({select = true})
        -- ['<TAB>'] = cmp.mapping.confirm({select = true})
    }
})

-- Disabling our autocomplete when using telescope
vim.cmd [[
augroup Cmp
    au!
    autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
augroup END
]]
