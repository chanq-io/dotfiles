{ pkgs, inputs, fenix, system, lib, ...}: 
{
  home.username = "cardamom";
  home.homeDirectory = "/home/cardamom";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    alsa-lib
    atk
    bat
    cairo
    cargo-make
    chafa
    clang
    cmake
    coreutils
    eza
    fd
    fenix.packages.${pkgs.system}.stable.toolchain
    fontconfig
    freetype
    fribidi
    fzf
    gdk-pixbuf
    git
    glib
    gnumake
    graphite2
    graphviz
    gtk3
    harfbuzz
    inputs.zen-browser.packages."${system}".default
    just
    lldb
    llvm
    libsoup_3
    lua5_1
    luarocks
    neofetch
    nodePackages.bash-language-server
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    nodejs
    openssl
    pango
    pkg-config
    pkgs.vscode-extensions.vadimcn.vscode-lldb
    podman
    protobuf
    ripgrep
    taplo
    tldr
    tree-sitter
    ueberzugpp
    unzip
    viu
    webkitgtk_4_1
    wget
    xclip
  ];

  imports = [
    ./modules/shell/zsh.nix
  ];

  programs.home-manager.enable = true;

  home.file.".cargo/config.toml" = {
    source = ./config/cargo/config.toml;
  };

  xdg.configFile."i3/config" = {
    source = ./config/i3/config;
  };

  xdg.configFile."kitty" = {
    source = ./config/kitty;
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
