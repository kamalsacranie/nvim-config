-- eventhough i have an async version of this. the file structure does not allow for this.
-- the alternative solution would be to do something like make an autocmd that every time we go to a new buffer, we
-- stop and start efm/ update the config if that's possible
local filetypes = vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/ftplugin")
local languages = {}
for _, ft in ipairs(filetypes) do
    languages[ft] = get_table_from_ftplugin_filtype("efm", ft)
end


return {
    filetypes = vim.tbl_keys(languages),
    settings = {
        rootMarkers = { ".git/" },
        languages = languages,
    },
    init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
    },
}
