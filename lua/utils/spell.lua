---@type opts
local spell_options = {
    buf = {
        spelllang = "en_gb",
        spellfile = vim.fn.stdpath("config") .. "/en.utf-8.add",
    },
    win = {
        spell = true,
    },
    glob = {
        spell = true,
    }
}

require("utils.options").set_all_options(spell_options)
