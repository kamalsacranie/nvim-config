local M = require("filetype.markdown_core")

local ls = require("luasnip")
ls.filetype_extend("markdown", M.snippet_types)

require("filetype.md.mappings")

return M
