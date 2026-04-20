{ ... }:

let
  theme = import ../../../lib/theme.nix;

  # Strip the leading "#" from a hex colour and add hyprland's alpha suffix.
  # Hyprland's rgba() takes 8 hex chars, no hash. e.g. "#e78a53" -> "e78a53ee".
  toHypr = hex: alpha: (builtins.substring 1 6 hex) + alpha;
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    # Hyprland comes from the system (programs.hyprland.enable in
    # modules/nixos/desktop.nix). Null here so HM doesn't install a
    # conflicting copy.
    package = null;
    portalPackage = null;

    systemd.variables = [ "--all" ];

    settings = {
      monitor = [
        "HDMI-A-3,3840x2160@30,0x0,1.5"
        ",preferred,auto,1"
      ];

      "$mod" = "SUPER";
      "$term" = "kitty";
      "$menu" = "wofi --show drun";

      exec-once = [
        # waybar + mako start via their systemd user units (programs.waybar
        # and services.mako). Additional daemons (swww, hypridle, cliphist,
        # gammastep) land here as their modules arrive.
      ];

      env = [
        "XCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(${toHypr theme.base0A "ee"}) rgba(${toHypr theme.base0D "ee"}) 45deg";
        "col.inactive_border" = "rgba(${toHypr theme.base02 "aa"})";
        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 6;
        active_opacity = 1.0;
        inactive_opacity = 0.95;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          range = 12;
          render_power = 3;
          color = "rgba(${toHypr theme.base00 "aa"})";
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "overshot,0.05,0.9,0.1,1.05"
          "smoothOut,0.36,0,0.66,-0.56"
          "smoothIn,0.25,1,0.5,1"
        ];
        animation = [
          "windows,1,5,overshot,slide"
          "windowsOut,1,4,smoothOut,slide"
          "border,1,10,default"
          "fade,1,10,smoothIn"
          "workspaces,1,6,default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      bind = [
        # Apps
        "$mod, Return, exec, $term"
        "$mod, D, exec, $menu"
        "$mod, Q, killactive"
        "$mod SHIFT, E, exit"
        "$mod SHIFT, R, exec, hyprctl reload"
        "$mod, F, togglefloating"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        "$mod, M, fullscreen"

        # Focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # Move window
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Resize submap not wired yet — placeholder for future.
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Volume / media keys (no playerctl yet; these still work with pipewire).
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];
    };
  };
}
