return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  opts = function()
    local root = vim.fn.stdpath('data') .. '/parsers'
    return {
      auto_install = false,
      ensure_installed = { 'rust' },
      parser_install_dir = root,
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
  config = function(_, opts)
    require('nvim-treesitter.install').compilers = { 'clang', 'gcc', 'clang++', 'g++' }
    require('nvim-treesitter.install').prefer_git = true

    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    if parser_config.rust and parser_config.rust.install_info then
      parser_config.rust.install_info.files = { 'src/parser.c', 'src/scanner.cc', 'src/scanner.c' }
    end

    require('nvim-treesitter.configs').setup(opts)

    vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/parsers/parser')
  end,
}
