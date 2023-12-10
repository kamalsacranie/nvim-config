local update_hl_by_name = function(hl_name, callback, hl_group)
    local hl = vim.api.nvim_get_hl(hl_group or 0,
        { name = hl_name })
    -- tables passed by reference
    callback(hl)
    vim.api.nvim_set_hl(hl_group or 0, hl_name, hl)
end

return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                delete       = { text = "_", show_count = true },
                topdelete    = { text = "‾", show_count = true },
                changedelete = { text = "~", show_count = true },
            },
        })
        update_hl_by_name("GitSignsChange", function(hl)
            hl.fg = "#fa6b05"
        end)
        local mapper = load_package("nvim-mapper")
        if not mapper then
            return print(
                "Attempted to map gitsigns mappings using mapper but mapper was not available.")
        end
        mapper.map_keymap_list(require("plugins.gitsigns.mappings"))
    end
}
