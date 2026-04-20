-- nvim-treesitter plugin removed: parsers and queries are installed into
-- nvim's site dir out-of-band (via Nix home-manager on Linux, via brew on
-- macOS). We only need to wire highlighting to the built-in treesitter
-- runtime.
--
-- In nvim 0.12+ this would be automatic. Shrike is on 0.11.7, so enable
-- per-buffer explicitly. pcall swallows errors for filetypes whose parser
-- we haven't installed — they just stay on regexp highlighting.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
