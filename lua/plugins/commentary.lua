-- Commentary

return {
    "numToStr/Comment.nvim",
    config = function()
        require("user.comment")
    end,
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring"
}
