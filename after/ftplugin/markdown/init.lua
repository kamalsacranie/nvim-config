-- syntax match ConcealedDetails /\s\s$/ conceal cchar=·

---@type opts
local md_opts = {
    buf = {
        tabstop = 2,
        softtabstop = 2,
        shiftwidth = 0,
        expandtab = true,
        textwidth = 80,
    },
    win = {
        colorcolumn = "81"
    }
}

require("utils.spell")

require("utils.options").set_all_options(md_opts)

require("nvim-mapper").map_keymap_list(require("ftplugin.markdown.mappings"),
    { buffer = true })
