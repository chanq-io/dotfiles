require('nvim-treesitter.configs').setup({
  auto_install = false,
  parser_install_dir = vim.fn.stdpath("data") .. "/parsers",
  ensure_installed = { "rust" },
  highlight = { enable = true },
  indent = { enable = true },
})

