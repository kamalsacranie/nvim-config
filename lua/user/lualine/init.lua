require 'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'nightfly',
        component_separators = { '', '' },
        section_separators = { '', '' },
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        -- Adding our lsp status. very rough but will do for now
        lualine_y = { function()
            return require("lsp-status").status()
        end, 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
