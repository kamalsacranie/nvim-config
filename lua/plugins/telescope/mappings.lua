local telezones = require("plugins.telescope.telezones")

---@return Keymap? ...: returns many tables
local generate_ranger_keybindings = function()
    local ranger_bookmarks = require("utils.ranger_bookmarks")
        .ranger_bookmarks_table()
    if not ranger_bookmarks then
        return nil
    end
    local result = {}
    for _, bookmark in ipairs(ranger_bookmarks) do
        local mark, path = unpack(bookmark)
        table.insert(result,
            { "n", "<leader>fr" .. mark, function()
                require("plugins.telescope.telezones").find_files({ cwd = path })
            end })
    end
    return unpack(result)
end

---@type Keymap[]
return {
    { "n", "*", function()
        require("telescope.builtin").grep_string({
            cwd = require(
                "telescope.utils").buffer_dir()
        })
    end },
    { "n", "<leader>ff", telezones.find_files },
    { "n", "<leader>fF", function()
        telezones.find_files({
            cwd = require("utils.helpers").root_directory_from_patterns(
                ".git"
            ),
        })
    end },
    { "n", "<leader>fh", require("telescope.builtin").help_tags },
    { "n", "<leader>fg", telezones.live_grep },
    { "n", "<leader>fb", require("telescope.builtin").buffers },
    { "n", "<leader>fv", telezones.nvim_config },
    { "n", "<leader>fk", require("telescope.builtin").keymaps },
    { "n", "<leader>fs", require("plugins.telescope.telezones").doc_symbols },
    { "n", "<C-g>",      function() pcall(require("telescope.builtin").git_files) end },
    generate_ranger_keybindings()
}
