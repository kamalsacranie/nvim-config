return {
	"dhruvasagar/vim-table-mode",
	config = function()
		vim.cmd([[let g:table_mode_header_fillchar="="]])
		vim.cmd([[let g:table_mode_corner="+"]])
		vim.cmd([[let g:table_mode_corner_corner="+"]])
	end,
	cmd = "TableModeToggle",
}
