if not vim.g.loaded_nvim_treesitter then return end
require("nvim-treesitter.configs").setup {
    rainbow = {enable = true, extended_mode = true, max_file_lines = nil}
}
