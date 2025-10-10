local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font('FiraCode Nerd Font Mono')
config.font_size = 10
config.color_scheme = 'darkmatrix'
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false 
config.hide_tab_bar_if_only_one_tab = true 

return config
