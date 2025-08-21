local parser_root = vim.fn.stdpath('data') .. '/parsers'        
local parser_dir  = parser_root .. '/parser'                    

require('nvim-treesitter.configs').setup({
  auto_install = false,
  ensure_installed = { 'rust' },     
  parser_install_dir = parser_root,  
  highlight = { enable = true },
  indent = { enable = true },
})

vim.opt.runtimepath:append(parser_dir)

-- pcall(function()
--   vim.treesitter.language.add('rust', { path = parser_dir .. '/rust.so', filetype = 'rust' })
-- end)

