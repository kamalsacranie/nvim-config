---@type vim.bo
local options = {
    tabstop = 2,
    softtabstop = 2,
    shiftwidth = 0,
    expandtab = true,
}

require("utils.options").set_buf_options(options)

require("nvim-mapper").map_keymap_list(require("ftplugin.haskell.mappings"))
