local M = {}

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
