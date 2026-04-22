{ pkgs, ... }:

let
  theme = import ../../../lib/theme.nix;
in
{
  programs.kitty = {
    enable = true;

    font = {
      name = theme.fonts.mono;
      size = 13;
    };

    settings = {
      # Visuals
      background_opacity = "0.9";
      cursor_shape = "beam";
      cursor_beam_thickness = "1.8";
      window_padding_width = 8;
      hide_window_decorations = "yes";
      confirm_os_window_close = 0;

      # Scrollback + performance
      scrollback_lines = 10000;
      enable_audio_bell = "no";

      # Base16 Black Metal (Bathory) palette
      foreground = theme.base05;
      background = theme.base00;
      selection_foreground = theme.base00;
      selection_background = theme.base05;
      cursor = theme.base05;
      cursor_text_color = theme.base00;
      url_color = theme.base0D;

      # Normal colours
      color0 = theme.base00;
      color1 = theme.base08;
      color2 = theme.base0B;
      color3 = theme.base0A;
      color4 = theme.base0D;
      color5 = theme.base0E;
      color6 = theme.base0C;
      color7 = theme.base05;

      # Bright colours
      color8 = theme.base03;
      color9 = theme.base08;
      color10 = theme.base0B;
      color11 = theme.base0A;
      color12 = theme.base0D;
      color13 = theme.base0E;
      color14 = theme.base0C;
      color15 = theme.base07;

      # Base16 extensions (base09, 0F etc.) mapped for apps that query them
      color16 = theme.base09;
      color17 = theme.base0F;
      color18 = theme.base01;
      color19 = theme.base02;
      color20 = theme.base04;
      color21 = theme.base06;
    };
  };
}
