local all_sources = require("plugins.cmp.sources")

local source_names = {}
for key, _ in pairs(all_sources) do
    source_names[key] = "[" .. key .. "]"
end

local default_sources = {
    all_sources.nvim_lsp,
    all_sources.luasnip,
    all_sources.path,
}

local setup = function()
    local cmp = require("cmp")
    local defaults = {
        formatting = {
            format = function(entry, vim_item)
                vim_item.menu = (source_names)[entry.source.name]
                return vim_item
            end
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end
        },
        sources = cmp.config.sources(default_sources),
        mapping = cmp.mapping.preset.insert(require("plugins.cmp.mappings"))
    }
    cmp.setup(defaults)
end

return {
    "hrsh7th/nvim-cmp",
    config = setup,
    event = { "InsertEnter" },
    dependencies = {
        { "L3MON4D3/LuaSnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-path" }
    }
}
