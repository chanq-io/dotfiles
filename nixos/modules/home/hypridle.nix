{ ... }:

{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          # 5 minutes → lock screen
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        # DPMS-off listener intentionally absent: toggling DPMS on this
        # 4K@30 HDMI link causes the monitor to drop signal long enough for
        # Hyprland to treat it as a disconnect, which reflows windows and
        # mangles fullscreen-app resolutions on resume.
      ];
    };
  };
}
