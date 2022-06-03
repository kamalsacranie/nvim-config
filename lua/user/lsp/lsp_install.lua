local is_loaded, lsp_installer = LOAD_PACKAGE("nvim-lsp-installer")
if not is_loaded then
    return
end


-- Only some of the installed servers are returned when we run
-- get_installed_servers on init
local lazy_lss = {
    "pyright",
    "bashls",
    "texlab"
}

local function get_server_names()
    local servers = {}
    for i, server in ipairs(lsp_installer.get_installed_servers()) do
        servers[i] = server.name
    end
    -- Adding in our stupid lsps that dont show
    for _, value in ipairs(lazy_lss) do
        if not has_key(servers, value) then
            table.insert(servers, 1, value)
        end
    end
    return servers
end

local servers = get_server_names()

local cfg = {
    ensure_installed = servers,
    ui = {
        keymaps = {
            toggle_server_expand = "<CR>",
            install_server = "i",
            update_server = "u",
            check_server_version = "c",
            update_all_servers = "U",
            check_outdated_servers = "C",
            uninstall_server = "X",
        },
    },

    log_level = vim.log.levels.INFO,
}

lsp_installer.setup(cfg)

return servers