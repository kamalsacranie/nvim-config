local options = {
    buffer = {
        tabstop = 2,
        softtabstop = 2,
        shiftwidth = 0,
        expandtab = true,
        textwidth = 80,
    },
    window = {
        colorcolumn = "81"
    }
}

for key, value in pairs(options.window) do
    vim.api.nvim_set_option_value(key, value,
        { win = vim.fn.win_getid(), scope = "local" })
end

for key, value in pairs(options.buffer) do
    vim.api.nvim_set_option_value(key, value, { buf = vim.fn.bufnr() })
end

local cmp = load_package("cmp")
if cmp then
    local all_sources = require("plugins.cmp.sources")
    cmp.setup.filetype("markdown", {
        sources = cmp.config.sources({
            all_sources.otter,
            all_sources.nvim_lsp,
            all_sources.luasnip,
            all_sources.path,
        })
    })
end
