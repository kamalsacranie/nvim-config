local M = {}

M.buffer_options = {
    tabstop = 2,
    softtabstop = 2,
    shiftwidth = 0,
    expandtab = true,
    textwidth = 80,
}

for key, value in pairs(M.buffer_options) do
    vim.api.nvim_set_option_value(key, value, { buf = 0 })
end

local cmp = load_package("cmp")
if cmp then
    cmp.setup.filetype("markdown", {
        sources = cmp.config.sources({
            { name = "otter" },
            { name = "luasnip" },
            { name = "nvim_lsp" },
            { name = "path" }
        })
    })
end

return M
