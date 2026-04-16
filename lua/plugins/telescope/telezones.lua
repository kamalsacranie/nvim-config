local M = {}

-- Search current directory or cwd passed in
M.find_files = function(opts)
    local defaults = {
        cwd = require("telescope.utils").buffer_dir(),
        follow = true,
        hidden = true,
        no_ignore = true,
    }
    opts = opts or {}
    defaults = vim.tbl_deep_extend("force", defaults, opts)
    require("telescope.builtin").find_files(defaults)
end

-- Search vim config
M.nvim_config = function()
    -- This allows us to create the custom tele env
    require("telescope.builtin").find_files({
        prompt_title = "NVimRC",
        -- Specifies where tele should look
        cwd = vim.fn.stdpath("config"),
        hidden = true,
        follow = true,
    })
end

-- ripgrep all files in directory
M.live_grep = function()
    require("telescope.builtin").live_grep({ cwd = require("telescope.utils").buffer_dir() })
end

M.doc_symbols = function()
    require("telescope.builtin").lsp_document_symbols({ show_line = true })
end

return M
