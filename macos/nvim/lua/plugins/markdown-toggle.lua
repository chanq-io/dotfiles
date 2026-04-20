return {
  "roodolv/markdown-toggle.nvim",
  config = function()
    require("markdown-toggle").setup({
      use_default_keymaps = false,
    })
  end,
  keys = {
    {
      "<Leader>x",  -- or "cx", "tx", etc.
      function() require("markdown-toggle").checkbox() end,
      mode = { "n", "v" },
      ft = { "markdown", "markdown.mdx" },
      desc = "Toggle checkbox"
    },
  },
}
