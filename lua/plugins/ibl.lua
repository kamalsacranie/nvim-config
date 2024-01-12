local default = {
    indent = {
        char = { " " },
        highlight = {
            -- "CursorLine",
            "Whitespace",
        },
    },
    whitespace = {
        highlight = {
            -- "CursorLine",
            "Whitespace",
        },
        remove_blankline_trail = false,
    },
    scope = {
        char = { "▎" },
        enabled = true,
        show_start = false,
        show_end = false,
        highlight = { "Function" },
        show_exact_scope = true,
    }
}

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function() require("ibl").setup(default) end
}
