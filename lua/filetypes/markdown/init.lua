local M = require("filetypes.markdown_core")

local ls = require("luasnip")
ls.filetype_extend("markdown", M.snippet_types)

require("filetypes.markdown.mappings")

return M