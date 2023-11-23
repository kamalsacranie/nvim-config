-- figure out how to only load this if we require completion. not sure how we are going to do this
return {
    "hrsh7th/nvim-cmp",
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "otter" } })
        })
    end,
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" }
    }
}
