return {
    {
        "rmagatti/auto-session",
        lazy = false,
        dependencies = {
            "nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
        },
        config = function()
            local opts = {
                auto_session_enabled = true,
                auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
                auto_save_enabled = true,
                auto_restore_enabled = true,
                auto_session_suppress_dirs = nil,
                auto_session_allowed_dirs = nil,
                auto_session_create_enabled = true,
                auto_session_enable_last_session = false,
                auto_session_use_git_branch = false,
                auto_restore_lazy_delay_enabled = true,
                log_level = "error",
            }

            vim.o.sessionoptions =
            "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
            require("auto-session").setup(opts)
        end,
    },
    {
        -- "kamalsacranie/nvim-mapper",
        dir = "/Users/kamalsacranie/Code/nvim-plugins/nvim-mapper",
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
            require("pandoc-preview").setup({})
            vim.keymap.set("v", "<leader><leader>p", function()
                require("pandoc-preview").preview()
            end)
        end,
        enabled = true,
    },
}
