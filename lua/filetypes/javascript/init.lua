local M = rerequire("filetypes.javascript_core")
local ls = require("luasnip")

ls.filetype_extend("javascript", M.snippet_types)

rerequire("filetypes.javascript.mappings")

return M