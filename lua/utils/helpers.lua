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

local send_keys_to_nvim = function(string)
    local keys = vim.api.nvim_replace_termcodes(string, true, false,
        true)
    return vim.api.nvim_feedkeys(keys, vim.api.nvim_get_mode().mode,
        false)
end

M.get_source_code = function(f)
    local t = debug.getinfo(f)
    if t.linedefined < 0 then
        print("source", t.source); return
    end
    local name = t.source:gsub("^@", "")
    local i = 0
    local text = {}
    for line in io.lines(name) do
        i = i + 1
        if i >= t.linedefined then text[#text + 1] = line end
        if i >= t.lastlinedefined then break end
    end
    return table.concat(text, "\n")
end


---@param mode Mode[]|Mode: The mode or list of modes the mapping should apply to
---@param left string
---@param right string|fun(fallback: unknown)
---@param opts table?
---@param ext_opts table?
---@param callback? fun(right: unknown): string|function
M.map_keymap = function(mode, left, right, opts, ext_opts, callback)
    local new_mapping;
    -- if callback then
    --     if type(right) == "string" then
    --         print(
    --             "Cannot provide callback when right hand side of keymap is string")
    --     end
    --     rhs = function()
    --         return callback(right)
    --     end
    -- else
    new_mapping = right
    -- end
    vim.keymap.set(mode, left,
        (mode == "v" and type(right) == "string") and right or
        M.get_current_key_map(mode, left, new_mapping),
        vim.tbl_deep_extend("keep", opts or {}, ext_opts or {}))
end

---@alias Mode "n" | "v" | "i" | "x" | "s"
---@class Keymap
---@field[1]  Mode[]|Mode: mode
---@field[2] string: left
---@field[3] string | fun(fallback: unknown|nil) right
---@field[4] table?: opts
---@param mappings Keymap[]: A list of keymaps follwing the `Keymap` type
---@param ext_opts table?: Options which will be additionally applied to every keymap in the given mapping list
---@param callback? fun(right: unknown|nil): string|function: A function which is passed the mapping
M.map_keymap_list = function(mappings, ext_opts, callback)
    ---@param mapping Keymap
    vim.tbl_map(function(mapping)
        local mode = mapping[1]
        local left = mapping[2]
        local right = mapping[3]
        local opts = mapping[4]
        M.map_keymap(mode, left, right, opts, ext_opts, callback)
    end, mappings)
end

---@param mode Mode[]|Mode
---@param left string
M.get_current_key_map = function(mode, left, right)
    mode = type(mode) == "table" and mode or { mode }
    local mappings = {}
    for _, m in ipairs(mode) do
        local current_mapping = vim.fn.maparg(left, m, nil, true)
        if current_mapping then
            mappings[m] = current_mapping.rhs or current_mapping.callback
        end
    end
    return function()
        if type(right) == "string" then
            return send_keys_to_nvim(right)
        end
        local current_mode = vim.api.nvim_get_mode().mode
        local prev_mapping = mappings[current_mode]
        if type(prev_mapping) == "string" then
            prev_mapping = function()
                send_keys_to_nvim(prev_mapping)
            end
        end
        if not prev_mapping then
            return right()
        end
        return right(prev_mapping)
    end
end

M.get_path_of_lua_script = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end

M.get_items_in_directory = function(path, error_callback, success_callback)
    vim.loop.fs_opendir(path, function(error, data)
        vim.schedule(function()
            if error then
                vim.api.nvim_echo({ { error, "WarningMsg" } }, true, {})
                return error_callback(error)
            end
            local files = {}
            local file = vim.loop.fs_readdir(data)
            while file ~= nil do
                table.insert(files, file)
                file = vim.loop.fs_readdir(data)
            end
            return success_callback(files)
        end)
    end)
end

return M
