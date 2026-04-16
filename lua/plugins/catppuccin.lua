require("catppuccin").setup({
    term_colors = false,
    dim_inactive = {
        enabled = true,
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = { "bold" },
        properties = {},
        types = {},
        operators = {},
    },
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        markdown = true,
    },
})
require("catppuccin").load()
