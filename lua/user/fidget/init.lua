local fidg_did_load, fidget = load_package("fidget")
if not fidg_did_load then
	return
end

fidget.setup({
	text = {
		spinner = {
			"🌑 ",
			"🌒 ",
			"🌓 ",
			"🌔 ",
			"🌕 ",
			"🌖 ",
			"🌗 ",
			"🌘 ",
		}, -- animation shown when tasks are ongoing
		done = "✔", -- character shown when all tasks are complete
		commenced = "Started", -- message shown when task starts
		completed = "Completed", -- message shown when task completes
	},
})
