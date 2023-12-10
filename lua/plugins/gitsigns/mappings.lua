local git_conditional_call = function(callback)
    return function(fallback)
        -- extend this to check asynchronously if we are in a buffer which is in a git directory
        if true then
            callback()
        else
            fallback()
        end
    end
end

local gs = load_package("gitsigns")
if not gs then
    print("Attempted to map keys without loading gitsigns")
    return
end

---@type Keymap[]
local mappings = {
    { "n", "<leader>hs", gs.stage_hunk },
    { "n", "<leader>hr", gs.reset_hunk },
    { "v", "<leader>hs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end },
    { "v", "<leader>hr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end },
    { "n", "<leader>hS", gs.stage_buffer },
    { "n", "<leader>hu", gs.undo_stage_hunk },
    { "n", "<leader>hR", gs.reset_buffer },
    { "n", "<leader>hp", gs.preview_hunk },
    { "n", "<leader>hb", function() gs.blame_line { full = true } end },
    { "n", "<leader>hd", gs.toggle_deleted },
    { "n", "<leader>hD", gs.diffthis },
}

---@param mapping Keymap
return vim.tbl_map(function(mapping)
    mapping[3] = git_conditional_call(mapping[3])
    return mapping
end, mappings)
