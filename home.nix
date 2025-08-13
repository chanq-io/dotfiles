{ pkgs, ...}: {
  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    eza
  ];

  imports = [
    ./modules/shell/zsh.nix
  ];

  programs.home-manager.enable = true;
}
