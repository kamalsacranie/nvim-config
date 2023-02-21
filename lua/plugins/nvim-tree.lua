-- File explorer
return {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    keys = "X",
    tag = "nightly",
    config = function()
        require("user.filetree")
    end,
}
