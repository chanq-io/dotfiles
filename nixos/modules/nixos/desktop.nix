{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  # programs.hyprland already adds xdg-desktop-portal-hyprland; stack the
  # GTK portal on top so GTK apps (file pickers, Betterbird, Spotify, etc.)
  # can talk to the portal. common.default = "*" lets GTK serve requests
  # the hyprland portal doesn't implement.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
}
