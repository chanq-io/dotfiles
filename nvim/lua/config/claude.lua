require("claudecode").setup({
  terminal = {
    snacks_win_opts = {
      wo = {
        winhighlight = "Normal:Normal,NormalFloat:Normal",
      },
      keys = {
        term_normal = { "<C-\\><C-n>", function() vim.cmd("stopinsert") end, mode = "t", desc = "Exit terminal mode" },
        esc_esc = { "<Esc><Esc>", function() vim.cmd("stopinsert") end, mode = "t", desc = "Exit terminal mode" },
      },
    },
  },
})
