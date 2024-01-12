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
    local cmp_lsp = require("cmp_nvim_lsp")

    local update_client_capabilities = function(client)
        client.server_capabilities =
            vim.tbl_deep_extend("force", client.server_capabilities,
                cmp_lsp.default_capabilities())
    end

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

    require("utils.helpers").get_items_in_directory(
        vim.fn.stdpath("config") .. "/after/ftplugin", function() end,
        function(data)
            data = vim.tbl_map(function(d) return d[1].name end, data)
            for _, filetype in ipairs(data) do
                local success, ftopts = pcall(get_table_from_ftplugin_filtype,
                    "cmp", filetype)
                if success then
                    cmp.setup.filetype(filetype,
                        {
                            sources = cmp.config.sources(#ftopts == 0 and
                                default_sources or ftopts)
                        })
                end
            end
        end)

    local lsp_clients = vim.lsp.get_clients()
    -- register completion for all active lsps
    vim.tbl_map(update_client_capabilities, lsp_clients)
    -- register completion for all new clients when they attach
    vim.api.nvim_create_autocmd("LspAttach", {
        group = "UserLspConfig",
        callback = function(env)
            local client = vim.lsp.get_client_by_id(env.data.client_id)
            update_client_capabilities(client)
        end
    })
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
