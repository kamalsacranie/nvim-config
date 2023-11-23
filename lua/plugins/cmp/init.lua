-- Set configuration for specific filetype.
-- cmp.setup.filetype("gitcommit", {
--     sources = cmp.config.sources({
--         { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
--     }, {
--         { name = "buffer" },
--     })
-- })

local setup = function()
    local cmp = require("cmp")
    cmp.setup({
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end
        },
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "otter" },
            { name = "luasnip" }
        }),
        mapping = cmp.mapping.preset.insert(require("plugins.cmp.mappings"))
    })
end

-- figure out how to only load this if we require completion. not sure how we are going to do this
return {
    "hrsh7th/nvim-cmp",
    config = setup,
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
        { "saadparwaiz1/cmp_luasnip" }
    }
}
