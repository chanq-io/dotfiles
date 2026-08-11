return {
  "abdul-hamid-achik/keymaps.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim", -- optional, for fuzzy finding
  },
  opts = {
    -- your configuration (see below)
  },
  keys = {
    { "<leader>?", "<cmd>Keymaps<cr>", desc = "Show Keymaps" },
  },
}

