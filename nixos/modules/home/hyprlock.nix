{ ... }:

let
  theme = import ../../../lib/theme.nix;

  # hyprlock rgba is RRGGBBAA (no hash). Mirror the helper from hyprland.nix
  # — small enough not to hoist to a shared lib yet.
  toHypr = hex: alpha: (builtins.substring 1 6 hex) + alpha;
in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
        ignore_empty_input = true;
      };

      background = [
        {
          # Fallback to solid Base16 background until swww gets a wallpaper.
          # Once ~/wallpapers/current.* exists, point path at it.
          path = "screenshot";
          blur_passes = 3;
          blur_size = 6;
          color = "rgba(${toHypr theme.base00 "ff"})";
        }
      ];

      input-field = [
        {
          size = "320, 50";
          position = "0, 0";
          halign = "center";
          valign = "center";
          outline_thickness = 2;
          dots_size = 0.3;
          dots_spacing = 0.3;
          dots_center = true;
          outer_color = "rgba(${toHypr theme.base0A "ee"})";
          inner_color = "rgba(${toHypr theme.base01 "cc"})";
          font_color = "rgba(${toHypr theme.base05 "ff"})";
          fade_on_empty = false;
          placeholder_text = "<i>password</i>";
          hide_input = false;
          check_color = "rgba(${toHypr theme.base0B "ee"})";
          fail_color = "rgba(${toHypr theme.base08 "ee"})";
          fail_text = "<i>$FAIL</i>";
          capslock_color = "rgba(${toHypr theme.base0A "ee"})";
        }
      ];

      label = [
        {
          text = "cmd[update:1000] date +\"%H:%M\"";
          color = "rgba(${toHypr theme.base05 "ff"})";
          font_size = 96;
          font_family = "FiraMono Nerd Font Mono";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:60000] date +\"%A, %d %B\"";
          color = "rgba(${toHypr theme.base04 "ff"})";
          font_size = 18;
          font_family = "FiraMono Nerd Font Mono";
          position = "0, 120";
          halign = "center";
          valign = "center";
        }
        {
          text = "$USER";
          color = "rgba(${toHypr theme.base0A "ff"})";
          font_size = 14;
          font_family = "FiraMono Nerd Font Mono";
          position = "0, -60";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
