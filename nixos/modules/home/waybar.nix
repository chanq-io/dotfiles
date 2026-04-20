{ ... }:

let
  theme = import ../../../lib/theme.nix;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.main = {
      layer = "top";
      position = "bottom";
      height = 30;
      spacing = 4;

      modules-left = [ "hyprland/workspaces" "hyprland/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "network" "cpu" "memory" "tray" ];

      "hyprland/workspaces" = {
        format = "{id}";
        on-click = "activate";
        sort-by-number = true;
      };

      "hyprland/window" = {
        format = "{title}";
        max-length = 60;
        separate-outputs = true;
      };

      clock = {
        format = "{:%H:%M  %a %d %b}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      cpu = {
        format = "  {usage}%";
        interval = 2;
      };

      memory = {
        format = "  {percentage}%";
        interval = 5;
      };

      network = {
        format-wifi = "  {essid}";
        format-ethernet = "  {ipaddr}";
        format-disconnected = "⚠ offline";
        tooltip-format = "{ifname}: {ipaddr}";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = " muted";
        format-icons = {
          default = [ "" "" "" ];
        };
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        on-click-right = "qpwgraph";
        scroll-step = 5;
      };

      tray = {
        icon-size = 18;
        spacing = 8;
      };
    };

    style = ''
      * {
        font-family: "FiraMono Nerd Font Mono", sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background-color: ${theme.base00};
        color: ${theme.base05};
        border-top: 1px solid ${theme.base02};
      }

      #workspaces button {
        padding: 0 8px;
        color: ${theme.base04};
        background-color: transparent;
        border-radius: 0;
      }

      #workspaces button.active {
        color: ${theme.base0A};
        border-bottom: 2px solid ${theme.base0A};
      }

      #workspaces button.urgent {
        color: ${theme.base08};
      }

      #workspaces button:hover {
        background-color: ${theme.base01};
        color: ${theme.base05};
        box-shadow: none;
        text-shadow: none;
      }

      #window, #clock, #cpu, #memory, #network, #pulseaudio, #tray {
        padding: 0 10px;
        color: ${theme.base05};
      }

      #clock {
        color: ${theme.base0A};
      }

      #network.disconnected {
        color: ${theme.base08};
      }

      #pulseaudio.muted {
        color: ${theme.base03};
      }
    '';
  };
}
