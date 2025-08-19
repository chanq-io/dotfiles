require('obsidian').setup({
  workspaces = {
    {
      name = "zettelkasten",
      path = "~/src/personal/zettelkasten",
    },
  },
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },
  mappings = {
    -- Open link
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ["<leader>t"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    -- Smart action depending on context, either follow link or toggle checkbox.
    ["<cr>"] = {
      action = function()
        return require("obsidian").util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    }
  },

})
