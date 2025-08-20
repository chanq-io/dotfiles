require('nvim-treesitter.configs').setup({
  auto_install = false,
  ensure_installed = { "rust" },
  highlight = { enable = true },
  indent = { enable = true },
})

