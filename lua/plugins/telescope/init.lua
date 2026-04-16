local telescope_loaded = false

local setup = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    -- Protected buffer delete to avoid error messages
    local pdelete_buffer = function(bufnr)
        local status, funct = pcall(actions.delete_buffer, bufnr)
        if status then
            return funct
        end
    end

    telescope.setup({
        defaults = {
            file_ignore_patterns = { ".git" },
            mappings = {
                n = {
                    ["q"] = actions.close,
                    ["<C-x>"] = pdelete_buffer,
                    ["<Esc>"] = actions.close,
                },
                i = {
                    ["<C-x>"] = pdelete_buffer,
                    ["<C-c>"] = actions.close,
                    ["<Esc>"] = actions.close,
                },
            },
            selection_caret = "",
            prompt_prefix = "❯ ",
        },
    })

    telescope.load_extension("fzf")
end

local function ensure_loaded()
    if telescope_loaded then
        return
    end
    telescope_loaded = true
    setup()
end

for _, mapping in ipairs(require("plugins.telescope.mappings")) do
    if type(mapping.rhs) == "string" then
        vim.keymap.set(mapping.modes, mapping.lhs, function()
            ensure_loaded()
            vim.api.nvim_feedkeys(vim.keycode(mapping.rhs), "m", false)
        end, mapping.opts)
    else
        vim.keymap.set(mapping.modes, mapping.lhs,
            function()
                ensure_loaded()
                mapping.rhs()
            end, mapping.opts)
    end
end
