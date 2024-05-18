--[[  ___          ___       ___                ___          ___       ___
     /\  \        /\  \     /\  \              /\__\        /\__\     /\  \
    /::\  \      /::\  \    \:\  \            /::|  |      /:/  /     \:\  \
   /:/\:\  \    /:/\:\  \    \:\  \          /:|:|  |     /:/  /       \:\  \
  /::\~\:\  \  /::\~\:\  \   /::\  \        /:/|:|  |__  /:/  /  ___   /::\  \
 /:/\:\ \:\__\/:/\:\ \:\__\ /:/\:\__\      /:/ |:| /\__\/:/__/  /\__\ /:/\:\__\
 \:\~\:\ \/__/\/__\:\/:/  //:/  \/__/      \/__|:|/:/  /\:\  \ /:/  //:/  \/__/
  \:\ \:\__\       \::/  //:/  /               |:/:/  /  \:\  /:/  //:/  /
   \:\ \/__/       /:/  / \/__/                |::/  /    \:\/:/  / \/__/
    \:\__\        /:/  /                       /:/  /      \::/  /
     \/__/        \/__/                        \/__/        \/__/          --]]

-- Loading our global functions for later use in setup
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("qol_globals")
-- Installing packer if vim doesn't have it
require("utils.lazy_bootstrap")
-- Setting our vanilla vim options
require("vanilla.sets")
require("vanilla.lets")
require("vanilla.autocmds")
-- Setting up our pligins
require("lazy").setup("plugins")

local function curry(fn, ...)
    local args = { ... }
    if #args == 0 then
        return fn
    end
    local first = table.remove(args, 1)
    return curry(function(...) fn(first, ...) end, unpack(args))
end

-- local function open_file(path, mode, perms, callback, next)
local function open_file(...)
    local args = { ... }
    if #args == 5 then
        return vim.uv.fs_open(args[1], args[2], args[3],
            function(err, file_descriptor)
                args[4](err, file_descriptor)                  -- callback
                args[5](err, file_descriptor, file_descriptor) -- next
            end)
    else
        return curry(open_file, unpack(args))
    end
end


local intercept = function(callback, state, next, err, data)
    err, data, state = callback(err, data, state)
    return next(err, data, state)
end

local function arrange(action, prev, callback)
    return function(next)
        return prev(function(err, data, state)
            local cb = curry(intercept, callback, state, next)
            return action(err, data, state, cb)
        end)
    end
end

local function open_file_(prev, path, mode, perms, callback)
    return arrange(
        function(err, data, state, cb)
            return vim.uv.fs_open(path, mode, perms,
                cb)
        end,
        prev, callback)
    -- return function(next)
    --     return prev(function(err, data, state)
    --         local cb = curry(intercept, callback, state, next)
    --         return vim.uv.fs_open(path, mode, perms, cb)
    --     end)
    -- end
end

-- local function write_file(data, `file`, callback, next)
local function write_file(...)
    local args = { ... }
    if #args == 4 then
        return args[2](function(_, _, fd)
            return vim.uv.fs_write(fd, args[1], nil, function(err, data)
                args[3](err, data)
                args[4](err, data, fd)
            end)
        end)
    else
        return curry(write_file, unpack(args))
    end
end

local function write_file_(prev, text, callback)
    return arrange(
        function(err, data, state, cb)
            return vim.uv.fs_write(data, text, nil, cb)
        end,
        prev, callback)
    -- return function(next)
    --     return prev(function(err, data, state)
    --         local cb = curry(intercept, callback, state, next)
    --         return vim.uv.fs_write(data, text, nil, cb)
    --     end)
    -- end
end

local function close_file(prev, callback)
    return arrange(
        function(err, data, state, cb)
            return vim.uv.fs_close(data,
                cb)
        end,
        prev, callback)
    -- return function(next)
    --     return prev(function(err, data, state)
    --         local cb = curry(intercept, callback, state, next)
    --         return vim.uv.fs_close(data, cb)
    --     end)
    -- end
end

local startProc = function(id) return id(nil, nil, {}) end
local endProc = function() end

-- for state, we can just pass through an empty table which can be modified in
-- the callbacks and is what should be returned. we can do err, val
local file = open_file_(startProc, "./temp.txt", "a+",
    bit.bor(0000200, 0000400),
    function(err, data, state)
        state.fd = data
        return err, data, state
    end)
file = write_file_(file, "text to write\n",
    function(err, _, state) return err, state.fd, state end)
file = write_file_(file, "text to write 2\n",
    function(err, _, state) return err, state.fd, state end)
file = close_file(file, function() print("closed file") end)
file(endProc)
