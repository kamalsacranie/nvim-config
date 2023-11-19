local M = {}

-- Generate the table of marks and paths
local _get_bookmarks_table = function(bookmarks_string)
    -- Split by new lines
    local bookmarks_table = vim.fn.split(bookmarks_string, [[\n]])
    local bookmarks_clean_table = {}
    for index, bookmark in ipairs(bookmarks_table) do
        local _, reps = bookmark:gsub(":", "") -- checking for only one split char in the string
        if reps == 1 then
            bookmarks_clean_table[index] = vim.fn.split(bookmark, ":")
        end
    end
    return bookmarks_clean_table
end

local get_raw_bookmarks = function(bookmarks_file_path)
    local bookmarks_file = io.open(bookmarks_file_path, "r") or nil
    if bookmarks_file then
        local bookmarks_string = bookmarks_file:read("a")
        bookmarks_file:close()
        return bookmarks_string
    end
    return nil
end

---@class RangerBookmark
---@field[1] string ranger mark
---@field[2] string mark path
---@param bookmarks_file_path string?: optional file path to specify where ranger stores bookmarks
---@return RangerBookmark[]?: The table of ranger shortcut bookmarks
M.ranger_bookmarks_table = function(bookmarks_file_path)
    bookmarks_file_path = bookmarks_file_path
        or vim.fn.expand("$XDG_DATA_HOME") .. "/ranger/" .. "bookmarks"
    local bookmarks_string = get_raw_bookmarks(bookmarks_file_path)
    if not bookmarks_string then
        return
    end
    return _get_bookmarks_table(bookmarks_string)
end

return M
