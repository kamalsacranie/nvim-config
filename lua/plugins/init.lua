return {
    {
        "kamalsacranie/nvim-mapper",
        config = function()
            local mapper = require("nvim-mapper")
            mapper.setup({ debug = true })
            mapper.map_keymap_list(require(
                "vanilla.mappings"))
        end,
        enabled = true,
    },
    { "folke/neoconf.nvim" },
    {
        "fladson/vim-kitty",
        enabled = false,
    },
    -- Devicons
    { "kyazdani42/nvim-web-devicons",  enabled = false },
    -- Highlight colour strings in nvim editr
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
        enabled = false
    },
    -- Document highlighting
    { "andymass/vim-matchup",          enabled = false },
    -- Good python indenting (might be obselete now)
    { "Vimjas/vim-python-pep8-indent", enabled = false },
    -- "kamalsacranie/nvim-jest-tester",
    {
        dir = "/Users/kamalsacranie/Code/nvim-plugins/pandoc-preview",
        config = function()
            vim.keymap.set("v", "<leader><leader>p", function()
                require("pandoc-preview").preview()
            end)
        end,
        enabled = true,
    },
}
