{ pkgs, inputs, fenix, system, lib, ...}: 
{
  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    eza
    fenix.packages.${pkgs.system}.rust-analyzer
    fenix.packages.${pkgs.system}.stable.toolchain
    graphviz
    inputs.zen-browser.packages."${system}".default
    lldb
    llvm
    neofetch
    pkgs.vscode-extensions.vadimcn.vscode-lldb
    ripgrep
    rust-analyzer
  ];

  imports = [
    ./modules/shell/zsh.nix
  ];

 
  programs.home-manager.enable = true;

  xdg.configFile."i3" = {
    source = ./config/i3/config;
    recursive = false;
  };


  xdg.configFile."polybar" = {
    source = ./config/polybar;
    recursive = false;
  };

  xdg.configFile."nvim" = {
    source = ./config/nvim;
    recursive = false;
  };
}
