{ pkgs, ... }:

{
  # swww-daemon autostart is wired in hyprland.nix exec-once. The daemon
  # does nothing until you run `swww img <path>` — once you drop a file
  # into ~/wallpapers/ and run that, hyprlock will also pick it up because
  # it grabs a fresh screenshot of the current output.
  home.packages = with pkgs; [ swww ];
}
