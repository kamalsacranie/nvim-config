return {
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		-- Pulled straigh from the github. Other languages are auto configed
		-- Also aut intergration with vim-commentary
		config = {
			--[[ python = { ]]
			--[[ 	__default = "# %s", ]]
			--[[ }, ]]
			--[[ bash = { ]]
			--[[ 	__default = "# %s", ]]
			--[[ }, ]]
			--[[ r = { ]]
			--[[ 	__default = "# %s", ]]
			--[[ }, ]]
			--[[ markdown = { ]]
			--[[ 	__default = "<!-- %s -->", ]]
			--[[ 	__multiline = "<!-- %s -->", ]]
			--[[ }, ]]
			lua = {
				__default = "-- %s ",
			},
		},
	},
}
