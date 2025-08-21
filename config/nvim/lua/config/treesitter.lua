require('nvim-treesitter.configs').setup({
  auto_install = false,
  ignore_install = { "all" },
  ensure_installed = { },
  highlight = { enable = true },
  indent = { enable = true },
})

vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/parsers")
