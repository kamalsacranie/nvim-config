return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require 'nvim-treesitter.configs'.setup({
            ensure_installed = "all",
            sync_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            auto_install = true,
            ignore_install = {},
        })
    end,
    enabled = true,
}
