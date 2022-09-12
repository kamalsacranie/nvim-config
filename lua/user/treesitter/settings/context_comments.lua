return {
	context_commentstring = {
		enable = true,
		-- Pulled straigh from the github. Other languages are auto configed
		-- Also aut intergration with vim-commentary
		config = {
			javascript = {
				__default = "// %s",
				jsx_element = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
				jsx_attribute = "// %s",
				comment = "// %s",
			},
			python = {
				__default = "# %s",
			},
			bash = {
				__default = "# %s",
			},
			r = {
				__default = "# %s",
			},
			markdown = {
				__default = "<!-- %s -->",
				__multiline = "<!-- %s -->",
			},
			lua = {
				__multiline = "-- %s ",
			},
		},
	},
}
