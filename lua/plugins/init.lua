return {
    {
        "rmagatti/auto-session",
        lazy = false,
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local opts = {
                auto_create = true,
                auto_restore = true,
                auto_restore_last_session = false,
                auto_save = true,
                enabled = true,
                git_use_branch_name = false,
                lazy_support = true,
                log_level = "error",
                root_dir = vim.fn.stdpath("data") .. "/sessions/",
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
    },
    -- Highlight colour strings in nvim editr
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({})
        end,
    },
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
