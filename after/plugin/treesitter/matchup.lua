if not vim.g.loaded_nvim_treesitter then return end
require("nvim-treesitter.configs").setup {requirematchup = {enable = true}}
