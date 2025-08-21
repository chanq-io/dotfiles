return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  -- event = { 'BufReadPost', 'BufNewFile' }, 
  opts = function()
    local root = vim.fn.stdpath('data') .. '/parsers'   
    local so_dir = root .. '/parser'                    
    return {
      auto_install = false,
      ensure_installed = { 'rust' }, 
      parser_install_dir = root,
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
  config = function(_, opts)
    require('nvim-treesitter.install').compilers = { 'clang' }
    require('nvim-treesitter.configs').setup(opts)
    -- Make Neovim see the compiled parsers
    vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/parsers/parser')
  end,
}

