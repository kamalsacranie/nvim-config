local setup = function()
    local comment = load_package("Comment")
    if not comment then
        return
    end

    comment.setup({
        pre_hook = require(
            "ts_context_commentstring.integrations.comment_nvim"
        ).create_pre_hook(),
        ignore = "^$"
    })
end

return {
    "numToStr/Comment.nvim",
    config = setup,
    keys = { "gc", "gb" },
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
}
