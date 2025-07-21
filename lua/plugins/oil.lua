return {
    "stevearc/oil.nvim",
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                ["q"] = {
                    callback = function()
                        vim.cmd [[q]]
                    end
                }
            }
        })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }
}
