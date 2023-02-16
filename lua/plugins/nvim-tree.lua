-- File explorer
return {
    "kyazdani42/nvim-tree.lua",
    depends = {
        "kyazdani42/nvim-web-devicons",
    },
    keys = "X",
    tag = "nightly",
    config = function()
        require("user.filetree")
    end,
}
