-- Checking if we've loaded treesitter
if not vim.g.loaded_nvim_treesitter then return end

require('nvim-treesitter.configs').setup {
    highlight = {enable = true, disable = {}},
    indent = {enable = true, disable = {'python'}},
    ensure_installed = {
        "tsx", "toml", "json", "yaml", "html", "css", "python", "lua",
        "javascript", 'latex'
    }
}
