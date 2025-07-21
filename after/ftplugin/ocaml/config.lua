local M = {}

M.treesitter = {
    textobjects = {
        select = {
            keymaps = {
                ["am"] = "@module.outer",
            },
        }
    }
}

return M
