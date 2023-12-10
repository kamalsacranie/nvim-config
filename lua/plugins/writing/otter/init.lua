local M = {}

-- Need to inject formatting with tree sitter. pretty sure I can do this
-- Figure out if there are any treesitter events that i might listen to
-- to call otter setup.
local otter_languages = { "python", "html", "latex" }
local keymap_options = { silent = true, buffer = true }
local mapper = require("nvim-mapper")
local mappings = require("plugins.writing.otter.mappings")

M.setup = function()
    mapper.map_keymap_list(mappings, keymap_options) -- do a check to only do this when we are in a viable otter space. otherwise we literally do it perpetually...
    vim.api.nvim_create_autocmd({ "CursorMovedI", "CursorMoved" }, {
        pattern = { "*.md", "*.qmd" },
        callback = function()
            require("otter").activate(otter_languages)
        end
    })
end

return M