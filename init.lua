---@class Keymap
---@field modes string|string[]
---@field lhs string
---@field rhs string|function
---@field opts vim.keymap.set.Opts?

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v", "o" }, "<Space>", "<Nop>")

for option_name, option_value in pairs(require("default-buffer-options")) do
    vim.opt[option_name] = option_value
end

for _, mapping in ipairs(require("default-mappings")) do
    vim.keymap.set(mapping.modes, mapping.lhs, mapping.rhs, mapping.opts)
end

for _, autocmd in ipairs(require("startup-autocmds")) do
    vim.api.nvim_create_autocmd(autocmd[1], autocmd[2])
end

local ftplugin_location = "/after/ftplugin"
package.path = package.path
    .. ";" .. vim.fn.stdpath("config") .. ftplugin_location .. "/?.lua"
    .. ";" .. vim.fn.stdpath("config") .. ftplugin_location .. "/?/init.lua"

local gh = function(coords)
    return "https://github.com/" .. coords
end

---@class vim.pack.CustomSpec : vim.pack.Spec
---@field pack_changed (fun(args: vim.api.keyset.create_autocmd.callback_args):boolean?)?

---@type vim.pack.CustomSpec[]
local plugins = {
    [gh "catppuccin/nvim"] = {
        name = "catppuccin",
    },
    gh "nvim-telescope/telescope.nvim",
    gh "nvim-lua/plenary.nvim",
    [gh "nvim-telescope/telescope-fzf-native.nvim"] = {
        pack_changed = function(ev)
            local kind = ev.data.kind
            if kind == "install" or kind == "update" then
                vim.system({ "make" }, { cwd = ev.data.path }):wait()
            end
        end
    },
    gh "williamboman/mason.nvim",
}

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local plugin_src = ev.data.spec.src
        local plugin = plugins[plugin_src]
        if plugin == nil or plugin.pack_changed == nil then
            return
        end
        plugin.pack_changed(ev)
    end,
})

vim.pack.add(
    vim.iter(pairs(plugins))
    :map(
        function(key, value)
            if type(key) == "number" then
                return { src = value }
            else
                return vim.tbl_extend("force", value, { src = key })
            end
        end
    )
    :totable()
)

require("mason").setup()
require("plugins.catppuccin")
require("plugins.telescope")
require("lsp-setup")
