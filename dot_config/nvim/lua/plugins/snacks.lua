-- Show git-ignored files (e.g. local drafts) in the explorer and the pickers.
-- Toggle per picker with <A-i> (ignored) / <A-h> (hidden), or I / H in the explorer.
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = { ignored = true },
          files = { ignored = true, exclude = { "node_modules" } },
          grep = { ignored = true, exclude = { "node_modules" } },
        },
      },
    },
  },
}
