{ pkgs, ... }:

let
  theme = import ../../../lib/theme.nix;

  # Waybar 0.14 duplicates bars on rapid monitor hotplug (the new output
  # event fires before the old bar instance is torn down). This listener
  # watches Hyprland IPC for monitor-added events and does a clean
  # systemctl restart with a short debounce so we always end up with
  # exactly one bar.
  waybar-monitor-guard = pkgs.writeShellScript "waybar-monitor-guard" ''
    socket="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
    debounce_pid=""
    ${pkgs.socat}/bin/socat -U - "UNIX-CONNECT:$socket" | while IFS= read -r line; do
      case "$line" in
        monitoraddedv2*|monitorremoved*)
          # Kill any pending debounce so rapid flickers collapse to one restart.
          [ -n "$debounce_pid" ] && kill "$debounce_pid" 2>/dev/null
          ( sleep 2 && systemctl --user restart waybar.service ) &
          debounce_pid=$!
          ;;
      esac
    done
  '';
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

  # Restart waybar on monitor hotplug so the bar-duplication bug can't
  # accumulate (waybar 0.14 race condition).
  systemd.user.services.waybar-monitor-guard = {
    Unit = {
      Description = "Restart waybar on Hyprland monitor hotplug";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
      ConditionEnvironment = "HYPRLAND_INSTANCE_SIGNATURE";
    };
    Service = {
      ExecStart = "${waybar-monitor-guard}";
      Restart = "on-failure";
      RestartSec = 2;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
