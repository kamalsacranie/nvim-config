local M = rerequire("filetype.markdown_core")

require("filetype.md.autocmds") -- no need to re-require autocmds as nvim stores them
rerequire("filetype.md.mappings")

return M
