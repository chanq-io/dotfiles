vim.opt.nu = true
vim.opt.tw = 80
vim.opt.hlsearch = true
vim.opt.ruler = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.backspace = "indent,eol,start"
vim.opt.background = "dark"
vim.opt.autoindent = true
vim.opt.mouse = "a"
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wildmode = "longest,list,full"
vim.opt.wildmenu = true
vim.opt.shell = "zsh"
vim.opt.conceallevel = 1
vim.g.pymode_rope = 0
vim.g.pymode_folding = 0
vim.opt.wildmenu = true
vim.opt.wildignore = vim.opt.wildignore + "*.swp,*.bak"
vim.opt.wildignore = vim.opt.wildignore + "*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*,*.o,*.obj"
vim.opt.wildignore = vim.opt.wildignore + "*/.git/**/*,*/.hg/**/*,*/.svn/**/*"
vim.opt.wildignore = vim.opt.wildignore + "*/min/*,*/vendor/*,*/node_modules/*,*/bower_components/*"
vim.opt.wildignore = vim.opt.wildignore + "tags,cscope.*"
vim.opt.wildignore = vim.opt.wildignore + "*.tar.*"
vim.opt.wildignorecase = true
vim.opt.termguicolors = true
vim.g.monochrome_italic_comments = true
vim.g.rustfmt_autosave = true
vim.g.rustfmt_emit_files = true
vim.g.rustfmt_fail_silently = false
vim.opt.fillchars = { eob = ' ' }

require("markdown-toggle").setup({
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    local mt = require("markdown-toggle")
    vim.keymap.set("n", "<C-Space>", mt.checkbox_dot, { buffer = true, expr = true, silent = true })
    vim.keymap.set("x", "<C-Space>", mt.checkbox, { buffer = true, silent = true })
  end,
})


vim.cmd [[
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    tnoremap <C-w>h <C-\><C-n><C-w>h
    tnoremap <C-w>j <C-\><C-n><C-w>j
    tnoremap <C-w>k <C-\><C-n><C-w>k
    tnoremap <C-w>l <C-\><C-n><C-w>l
    syntax enable
    au BufEnter * if &buftype == 'terminal' | :startinsert | endif
    nnoremap ,b :buffer *
    
    set t_Co=16
    hi NormalFloat guibg=None ctermbg=None
    hi CursorLine guibg=NONE guifg=NONE
    hi NonText ctermbg=none
    hi Normal guibg=NONE ctermbg=NONE

    colorscheme darkmatrix

    au BufNewFile,BufRead *.rs set filetype=rust
    au BufNewFile,BufRead *.toml set filetype=toml
    au FileType make setlocal noexpandtab
    autocmd FileType markdown setlocal spell
    autocmd FileType gitcommit setlocal spell
    if system('uname -s') == "Darwin\n"
      set clipboard=unnamed "OSX
    else
      set clipboard=unnamedplus "Linux
    endif

]]
