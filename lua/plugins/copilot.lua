return {
    "zbirenbaum/copilot.lua",
    config = function()
        require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    accept = "<C-f>",
                    accept_word = false,
                    accept_line = false,
                    next = "<D-]>",
                    prev = "<D-[>",
                    dismiss = "<D-[><D-]>",
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
    end,
    event = "InsertEnter",
}
