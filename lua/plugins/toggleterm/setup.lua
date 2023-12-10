local M = {}

M.map_term_nav_keys = function()
    require("nvim-mapper").map_keymap_list(require(
        "plugins.toggleterm.mappings").terminal, { buffer = true })
end

M.setup = function()
    -- these apply to all terminals created
    require("toggleterm").setup({
        -- size can be a number or function which is passed the current terminal
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.4
            end
        end,
        open_mapping = [[<c-\>]],
        -- on_create = fun(t: Terminal), -- function to run when the terminal is first created
        on_open = function(t)
            -- manual autochdir so we can override for each term
            local cwd = vim.fn.getcwd()
            if t.dir ~= cwd then t:change_dir(cwd) end
            M.map_term_nav_keys()
        end, -- function to run when the terminal opens
        -- on_close = fun(t: Terminal), -- function to run when the terminal closes
        -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
        -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
        -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
        hide_numbers = true,      -- hide the number column in toggleterm buffers
        -- shade_filetypes = {},
        autochdir = false,        -- when neovim changes it current directory the terminal will change it's own when next it's opened
        shade_terminals = true,   -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
        start_in_insert = true,
        insert_mappings = true,   -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        persist_size = true,
        persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
        direction = "float",
        close_on_exit = true,     -- close the terminal window when the process exits
        -- Change the default shell. Can be a string or a function returning a string
        shell = vim.o.shell,
        auto_scroll = true, -- automatically scroll to the bottom on terminal output
        --[[ float_opts = {
    border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    -- like `size`, width and height can be a number or function which is passed the current terminal
    width = <value>,
    height = <value>,
    winblend = 3,
    zindex = <value>,
  }, ]]
    })
    require("nvim-mapper").map_keymap_list(
        require("plugins.toggleterm.mappings").general, { buffer = true })
end

return M
