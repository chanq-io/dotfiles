require('nvim-treesitter.configs').setup({
    ensure_installed = { "rust" }, 
    highlight = { enable = true },
    indent = { enable = true },
    parser_install_dir = "/dev/null",
})
