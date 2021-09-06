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
        file_sorter = require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        path_display = {},
        -- set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new
    }
}

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
-- Git files????
vim.api.nvim_set_keymap('n', '<C-p>',
                        "<cmd>lua require('telescope.builtin').git_files()<CR>",
                        {noremap = true})
