return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{ "s", false, mode = { "v" } }, -- Disable 's' in visual mode
		{ "S", false, mode = { "v" } }, -- Disable 'S' in visual mode
	},
}
