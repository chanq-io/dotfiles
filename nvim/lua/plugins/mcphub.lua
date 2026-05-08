return {
  "ravitemer/mcphub.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  build = "bundled_build.lua",
  cmd = { "MCPHub" },
  config = function()
    require("mcphub").setup({
      use_bundled_binary = true,
    })
  end,
}
