local M = {}

M.cmp = function()
    local all_sources = require("plugins.cmp.sources")
    return {
        all_sources.otter,
        all_sources.nvim_lsp,
        all_sources.luasnip,
        all_sources.path,
    }
end

M.luasnip = function()
    return {
        ft_func = function(...)
            local snip_at_cursor = require("luasnip.extras.filetype_functions")
                .from_cursor_pos(...)
            if vim.tbl_contains(snip_at_cursor, "latex") then
                return snip_at_cursor
            end
            if vim.tbl_contains(snip_at_cursor, "markdown") or vim.tbl_contains(snip_at_cursor, "markdown_inline") then
                table.insert(snip_at_cursor, "markdown_core")
            end
            return snip_at_cursor
        end,
        load_ft_func = require("luasnip.extras.filetype_functions")
            .extend_load_ft({
                markdown = { "markdown_core", "markdown", "latex", "python" }, -- filetypes we will always need
            })
    }
end

return M
