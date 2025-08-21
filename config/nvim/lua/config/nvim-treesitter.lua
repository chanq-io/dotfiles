local ok, configs = pcall(require, 'nvim-treesitter.configs')
if ok then
  configs.setup({
    auto_install = false,
    ensure_installed = {},
    highlight = { enable = true },
    indent = { enable = true },
  })
end

