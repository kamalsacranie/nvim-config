if not vim.g.loaded_nvim_treesitter then return end
require("nvim-treesitter.configs").setup {
    context_commentstring = {
        enable = true,
        -- Pulled straigh from the github. Other languages are auto configed
        -- Also aut intergration with vim-commentary
        config = {
            javascript = {
                __default = '// %s',
                jsx_element = '{/* %s */}',
                jsx_fragment = '{/* %s */}',
                jsx_attribute = '// %s',
                comment = '// %s'
            }
        }
    }
}
