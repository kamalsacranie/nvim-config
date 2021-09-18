-- Checking if we've loaded treesitter
if not vim.g.loaded_nvim_treesitter then return end

require('nvim-treesitter.configs').setup {
    highlight = {enable = true, disable = {}},
    indent = {enable = true, disable = {}},
    ensure_installed = {
        "tsx", "toml", "json", "yaml", "html", "css", "python", "lua"
    },
    autotag = {enable = true},
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
    },
    rainbow = {enable = true, extended_mode = true, max_file_lines = nil},
    matchup = {enable = true}
}
