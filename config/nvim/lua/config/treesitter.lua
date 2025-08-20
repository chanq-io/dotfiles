require('nvim-treesitter.configs').setup({
    ensure_installed = { "rust" }, 
    highlight = { enable = true },
    indent = { enable = true },
    auto_install = false,
})
