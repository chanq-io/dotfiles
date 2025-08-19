{ pkgs, inputs, fenix, system, lib, ...}: 
{
  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    eza
    fenix.packages.${pkgs.system}.stable.toolchain
    graphviz
    inputs.zen-browser.packages."${system}".default
    lldb
    lua5_1
    luarocks
    llvm
    neofetch
    pkgs.vscode-extensions.vadimcn.vscode-lldb
    ripgrep
  ];

  imports = [
    ./modules/shell/zsh.nix
  ];

 
  programs.home-manager.enable = true;

  xdg.configFile."i3" = {
    source = ./config/i3/config;
    recursive = true;
  };


  xdg.configFile."polybar" = {
    source = ./config/polybar;
    recursive = true;
  };

  xdg.configFile."nvim" = {
    source = ./config/nvim;
    recursive = true;
  };
}
