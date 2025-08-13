{ pkgs, inputs, system, lib, ...}: {
  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    eza
    inputs.zen-browser.packages."${system}".default
    neofetch
  ];

  imports = [
    ./modules/shell/zsh.nix
  ];

  programs.home-manager.enable = true;
}
