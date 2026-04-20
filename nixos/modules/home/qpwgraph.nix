{ pkgs, ... }:

{
  # PipeWire patchbay GUI. No config needed — state lives in the user's
  # ~/.config/rncbc.org/. Available as a right-click on the waybar
  # pulseaudio module (see waybar.nix).
  home.packages = with pkgs; [ qpwgraph ];
}
