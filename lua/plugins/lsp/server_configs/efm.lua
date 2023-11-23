-- Register linters and formatters per language
local black = require("efmls-configs.formatters.black")
local languages = {
    python = { black },
}

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
