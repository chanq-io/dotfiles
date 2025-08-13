{ pkgs, ...}: {
  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    eza
  ];

  imports = [
    ./modules/shell.nix
  ];

  programs.home-manager.enable = true;
}
