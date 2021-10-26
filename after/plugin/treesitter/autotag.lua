-- if not vim.g.loaded_nvim_treesitter then return end
require("nvim-treesitter.configs").setup {
    autotag = {
        enable = true,
        filetypes = {
            'html', 'javascript', 'javascriptreact', 'typescriptreact',
            'svelte', 'vue', 'django'
        }
    }
}
