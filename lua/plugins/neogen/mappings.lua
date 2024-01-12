---@type Keymap[]
return {
    { "n", "<leader>ng", function()
        require("neogen").generate({})
    end },
    { "n", "<leader>nt", function()
        require("neogen").generate({ type = "type" })
    end },
    { "n", "<leader>nf", function()
        require("neogen").generate({ type = "func" })
    end },
}
