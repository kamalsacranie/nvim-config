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

local function open_file_(prev, path, mode, perms, callback)
    return function(next)
        return prev(function(a, b, c)
            return vim.uv.fs_open(path, mode, perms,
                function(err, file_descriptor)
                    callback(err, file_descriptor)
                    next(err, file_descriptor, file_descriptor)
                end)
        end)
    end
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

local function write_file_(prev, data, callback)
    return function(next)
        return prev(function(_, _, fd)
            return vim.uv.fs_write(fd, data, nil, function(err, data)
                callback(err, data)
                next(err, data, fd)
            end)
        end)
    end
end

local function close_file(prev, callback)
    return function(next)
        return prev(function(_, data, fd)
            return vim.uv.fs_close(fd, function(err, data)
                callback(err, data)
                next(err, data, fd)
            end)
        end)
    end
end

local startProc = function(id) return id() end
local endProc = function() end

-- for state, we can just pass through an empty table which can be modified in
-- the callbacks and is what should be returned. we can do err, val
-- local file = open_file_(startProc, "./temp.txt", "a+",
--     bit.bor(0000200, 0000400),
--     function() print("opening") end)
-- file = write_file_(file, "text to write\n", function() print("writing") end)
-- file = write_file_(file, "text to write 2\n",
--     function() print("writing again!!") end)
-- file = close_file(file, function() print("closed file") end)
-- file(endProc)
