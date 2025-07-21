return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    opts = {
        ---@type lc.lang
        lang = "typescript"
    },
}
