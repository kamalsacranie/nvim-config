local setup = function()
	local pf_did_load, pretty_fold = load_package("pretty-fold")
	if not pf_did_load then
		return
	end
	pretty_fold.setup({
		sections = {
			left = {
				"content",
				"╟",
			}, -- auto expands to the content line of the fold
			right = {
				" ",
				"number_of_folded_lines", -- displays number of folded lines
				" ",
				function(config)
					return config.fill_char:rep(3)
				end,
				"╮",
			},
		},
		fill_char = "─",
	})
end

return {
	"anuvyklack/pretty-fold.nvim",
	dependencies = "anuvyklack/keymap-amend.nvim",
	config = setup,
}
