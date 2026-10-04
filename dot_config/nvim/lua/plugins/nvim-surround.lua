return {
	"kylechui/nvim-surround",
	version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	-- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
	config = function()
		require("nvim-surround").setup({
			-- Configuration here, or leave empty to use defaults
			-- Comp <https://vi.stackexchange.com/questions/45454/cs-is-not-working-when-nvim-surround-is-installed-via-lazyvim>
			-- Test on 2024-09-01 - Added modifier `g` in front of the commands
		})
	end,
}
