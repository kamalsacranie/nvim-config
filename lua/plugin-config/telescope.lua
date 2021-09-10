require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            'rg', '--color=never', '--no-heading', '--with-filename',
            '--line-number', '--column', '--smart-case'
        },
        prompt_prefix = "",
        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {mirror = false},
            vertical = {mirror = false}
        },
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new
    },

    -- Configuring tele with fzf. we will see how we like it
    extensions = {
        fzf = {
            fuzzy = true, -- fuzzy matching
            override_generic_sorter = false,
            override_file_sorter = true -- override the file sorter
        }
    }
}

-- Defining custom search zones like my nvrc
-- Defining M like this so that if I decide to setup more I can modulise this setup
local M = {}
M.search_dotfiles = function()
    -- This allows us to create the custom tele env
    require('telescope.builtin').find_files({
        prompt_title = '< NVimRC>',
        -- Specifies where tele should look
        cwd = vim.env.XDG_CONFIG_HOME .. '/nvim',
        hidden = true
    })
end

-- Calling fzf native plugin
require('telescope').load_extension('fzf')

-- Keymappings: f for find
-- other files in cwd
vim.api.nvim_set_keymap('n', '<leader>ff',
                        "<cmd>lua require('telescope.builtin').find_files()<CR>",
                        {noremap = true})
-- grep text in files (im guessing)
vim.api.nvim_set_keymap('n', '<leader>fg',
                        "<cmd>lua require('telescope.builtin').live_grep()<CR>",
                        {noremap = true})
-- list buffers
vim.api.nvim_set_keymap('n', '<leader>fb',
                        "<cmd>lua require('telescope.builtin').buffers()<CR>",
                        {noremap = true})
-- fuzzy search helptags
vim.api.nvim_set_keymap('n', '<leader>fh',
                        "<cmd>lua require('telescope.builtin').help_tags()<CR>",
                        {noremap = true})
-- Git project files. very naaace
vim.api.nvim_set_keymap('n', '<C-p>',
                        "<cmd>lua require('telescope.builtin').git_files()<CR>",
                        {noremap = true})
-- Vimrc file searc
vim.api.nvim_set_keymap('n', '<leader>fv',
                        "<cmd>lua require('plugin-config/telescope').search_dotfiles()<CR>",
                        {noremap = true})

return M
