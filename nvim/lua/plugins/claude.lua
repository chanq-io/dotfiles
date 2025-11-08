return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- "ravitemer/mcphub.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" }
    },
  },
  opts = {
    opts = {
      log_level = "DEBUG", 
    },
  },
} 
