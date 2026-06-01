-- vimtex — LaTeX authoring + Zathura SyncTeX integration.
-- Lazy-loads on .tex filetype. Backward search (Ctrl-click in Zathura → cursor
-- in neovim) works automatically because vimtex passes --synctex-editor-command
-- when it launches the viewer via :VimtexView (mapped to \lv).
return {
  "lervag/vimtex",
  lazy = false, -- vimtex's own recommendation: do not lazy-load
  ft = { "tex", "latex", "bib" },
  init = function()
    -- Must be set BEFORE vimtex loads, hence init = function() not config.
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_quickfix_mode = 0          -- don't auto-open quickfix on warnings
    vim.g.vimtex_mappings_prefix = "\\l"    -- default; uses maplocalleader = "\"
    vim.g.vimtex_syntax_conceal_disable = 1 -- keep raw source visible
  end,
}
