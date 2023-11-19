local M = {}

--- Recursively walk up the file system until a directory is reached
--- which contains a file/folder with th given filename
---@param dir string? the directory in which you want the search to start
---@param root_patterns string | string[] file you want to match in a parent directory
---@return string | nil) the root directory with no trailing slash if it exists
M.root_directory_from_patterns = function(root_patterns, dir)
    local root_dir = vim.fs.dirname(vim.fs.find(
        vim.fn.flatten({ root_patterns }),
        { upward = true }
    )[1], { path = dir })
    return root_dir
end

----- Coordinate structure
---@class Coordinates
---@field start_row number
---@field start_col number
---@field end_row number
---@field end_col number
--- Returns start and end row col coordinates for visual selection
---@return Coordinates? -- TODO create coordinate struct
M.get_visual_selection_coordinates = function()
    local start_pos, end_pos = vim.fn.getpos "'<", vim.fn.getpos "'>"
    if not start_pos or not end_pos then
        return nil
    end
    local coordinates = {
        start_row = start_pos[2] - 1,
        start_col = start_pos[3] - 1,
        end_row = end_pos[2] - 1,
        end_col = end_pos[3] - 1
    }
    return coordinates
end

--- Returns the current buffer directory or nil
---@return string | nil
M.current_buffer_dir = function()
    local bufnr = vim.fn.bufnr()
    return vim.fn.bufexists(bufnr) == 1 and vim.fn.getcwd(bufnr) or nil
end

--- Checks if we are in a git repo
---@return boolean
M.is_git_repo = function()
    local cd = M.current_buffer_dir()
    if not cd then
        return false
    end
    local dir = M.root_directory_from_patterns(cd, ".git")
    if dir then
        return true
    end
    return false
end

--- Revers a list-like table
---@param list List
---@return List
M.reverse_list_table = function(list)
    local len = #list
    local result = vim.deepcopy(list)
    for i = 1, math.floor(len / 2) do
        result[i], result[len - i + 1] = result[len - i + 1], result[i]
    end
    return result
end


----- Coordinate structure
---@class Keymap
---@field[1] string: mode
---@field[2] string: left
---@field[3] string | function: right
---@field[4] table?: opts
---@param mappings Keymap[]
---@param ext_opts table?
---@param callback function?
---@return nil
M.map_keymap_list = function(mappings, ext_opts, callback)
    ext_opts = ext_opts or {}
    vim.tbl_map(function(mapping)
        local mode, left, right, opts = unpack(mapping)
        local rhs;
        if callback then
            if type(right) == "string" then
                print("Cannot provide callback when right hand side of keymap is string")
            end
            rhs = function()
                callback(right)
            end
        else
            rhs = right
        end
        vim.keymap.set(mode, left, rhs, vim.tbl_deep_extend("keep", opts or {}, ext_opts))
    end, mappings)
end

return M
