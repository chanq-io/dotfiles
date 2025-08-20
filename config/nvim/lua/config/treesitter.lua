local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
for lang, config in pairs(parser_config) do
  config.install_info = {
    url = config.install_info.url,
    files = config.install_info.files,
    branch = config.install_info.branch,
  }
end

require('nvim-treesitter.configs').setup({
  auto_install = false,
  parser_install_dir = vim.fn.stdpath("data") .. "/parsers",
  ensure_installed = { "rust" },
  highlight = { enable = true },
  indent = { enable = true },
})

