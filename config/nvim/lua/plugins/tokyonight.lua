return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    styles = {
       sidebars = "transparent",
       floats = "transparent"
    },
    terminal_colours = true,
    hide_inactive_statusline = true,
    lualine_bold = true,
    on_colors = function(colors)
        colors.bg_statusline = colors.none
    end,
  }
};
