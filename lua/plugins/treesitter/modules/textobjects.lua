return {
    select = {
        enable = true,
        lookahead = true,
        keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
        },
        selection_modes = {
            ["@function.outer"] = "V",
            ["@function.inner"] = "v",
        },
    },
}
