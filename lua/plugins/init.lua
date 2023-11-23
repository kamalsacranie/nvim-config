return {
    {
        'mhartington/formatter.nvim',
        config = function()
            require("formatter").setup({
                filetype = {
                    python = require("formatter.filetypes.python").black
                }
            })
        end,
        enabled = false
    },
    -- Kitty config highlighting
    { "fladson/vim-kitty",            enabled = false },
    -- Devicons
    { "kyazdani42/nvim-web-devicons", enabled = false },
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
    {
        "jose-elias-alvarez/null-ls.nvim",
        -- we don't have a config setup here because this is called in our lsp init
        dependencies = "nvim-lua/plenary.nvim",
        enabled = false,
    },
    -- "kamalsacranie/nvim-jest-tester",
    {
        "3rd/image.nvim",
        config = function()
            package.path = package.path
                .. ";"
                .. vim.fn.stdpath("data")
                .. "/luarocks/share/lua/5.1/?/init.lua;"
            package.path = package.path
                .. ";"
                .. vim.fn.stdpath("data")
                .. "/luarocks/share/lua/5.1/?.lua;"
            require("image").setup()
        end,
        build = "luarocks --tree /Users/kamalsacranie/.local/share/nvim/lazy install magick",
        enabled = false,
    },
    {
        dir = "/Users/kamalsacranie/Code/nvim-plugins/pandoc-preview",
        config = function()
            vim.keymap.set("v", "<leader><leader>p", function()
                require("pandoc-preview").preview()
            end)
        end,
        enabled = false,
    },
}
