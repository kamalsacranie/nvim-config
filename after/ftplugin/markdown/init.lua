local M = {}

M.options = {
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

for key, value in pairs(M.options.window) do
    vim.api.nvim_set_option_value(key, value,
        { win = vim.fn.win_getid(), scope = "local" })
end

for key, value in pairs(M.options.buffer) do
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

-- arguably should make this our default ft func
M.luasnip = {
    ft_func = function(...)
        local snip_at_cursor = require("luasnip.extras.filetype_functions")
            .from_cursor_pos(...)
        if vim.tbl_contains(snip_at_cursor, "latex") then
            return snip_at_cursor
        end
        if vim.tbl_contains(snip_at_cursor, "markdown") or vim.tbl_contains(snip_at_cursor, "markdown_inline") then
            table.insert(snip_at_cursor, "markdown_core")
            return snip_at_cursor
        end
        require("luasnip.loaders.from_vscode").load({
            paths = {
                vim.fn.stdpath("data") .. "/lazy/friendly-snippets",
            },
            override_priority = 999,
            include = snip_at_cursor
        })
        return snip_at_cursor
    end,
    load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
        markdown = { "markdown_core", "markdown", "latex" }, -- filetypes we will always need
    })
}

return M
