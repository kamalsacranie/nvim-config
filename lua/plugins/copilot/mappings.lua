---@type Keymap[]
return {
    { "n", "<leader>ct", function()
        require("copilot.suggestion").toggle_auto_trigger()
        print("Turned copilot " ..
            (vim.b.copilot_suggestion_auto_trigger and "on" or
                "off"))
    end }
}
