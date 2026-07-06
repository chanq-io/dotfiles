local scnvim = require 'scnvim'
local map = scnvim.map
local map_expr = scnvim.map_expr

-- resolve pandoc from PATH (portable across macOS/NixOS); nil => browser fallback
local pandoc = vim.fn.exepath('pandoc')

scnvim.setup({
  keymaps = {
    ['<M-e>'] = map('editor.send_line', {'i', 'n'}),
    ['<C-e>'] = {
      map('editor.send_block', {'i', 'n'}),
      map('editor.send_selection', 'x'),
    },
    ['<CR>'] = map('postwin.toggle'),
    ['<M-CR>'] = map('postwin.toggle', 'i'),
    ['<M-L>'] = map('postwin.clear', {'n', 'i'}),
    ['<C-k>'] = map('signature.show', {'n', 'i'}),
    ['<F5>'] = map('sclang.hard_stop', {'n', 'x', 'i'}),
    ['<leader>1'] = map('sclang.start'),
    ['<leader>2'] = map('sclang.recompile'),
    ['<leader>9'] = map_expr('s.boot'),
    ['<leader>0'] = map_expr('s.meter'),
  },
  editor = {
    highlight = {
      color = 'IncSearch',
    },
  },
  postwin = {
    float = {
      enabled = true,
    },
  },
  documentation = {
    cmd = pandoc ~= '' and pandoc or nil,
  },
})

require('telescope').load_extension('scdoc')

vim.keymap.set('n', '<leader>5', '<cmd>Telescope scdoc<cr>', { desc = 'SuperCollider docs' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'supercollider',
  callback = function()
    vim.cmd('SCNvimStart')
    vim.keymap.set('n', 'K', function()
      vim.cmd('SCNvimHelp ' .. vim.fn.expand('<cword>'))
    end, { buffer = true, desc = 'SuperCollider help for word under cursor' })
  end,
})
