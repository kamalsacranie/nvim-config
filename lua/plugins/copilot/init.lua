return {
    "zbirenbaum/copilot.lua",
    config = function()
        require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = false,
                debounce = 75,
                keymap = {
                    accept = "<C-f>",
                    accept_word = false,
                    accept_line = false,
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<M-[><M-]>",
                },
            },
            filetypes = {
                yaml = false,
                markdown = true,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ["."] = false,
            },
            copilot_node_command = "node",
        })
        require("nvim-mapper").map_keymap_list(
            require("plugins.copilot.mappings"), {})
    end,
    event = "InsertEnter",
}
