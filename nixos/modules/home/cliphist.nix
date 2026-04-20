{ pkgs, ... }:

{
  # cliphist daemon watches wl-clipboard and stores history. Super+V picks
  # via wofi dmenu (keybind in hyprland.nix). Images and text both
  # supported — the list/decode/delete commands are handled by the cliphist
  # binary itself.
  services.cliphist = {
    enable = true;
    allowImages = true;
    systemdTarget = "hyprland-session.target";
  };

  home.packages = with pkgs; [ wl-clipboard ];
}
