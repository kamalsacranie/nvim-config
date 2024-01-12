return {
    "j-hui/fidget.nvim",
    config = function()
        require("fidget").setup({
            progress = { display = { render_limit = 4, progress_icon = { pattern = "moon" } } },
        })
    end
}
