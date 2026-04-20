{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Files & navigation
    eza
    bat
    fd
    ripgrep
    fzf
    zoxide
    yazi

    # Text & search
    silver-searcher
    jq
    glow
    tldr

    # Monitoring
    btop
    procs
    dust
    duf
    bandwhich

    # HTTP / API
    httpie
    xh
    slumber

    # Network basics
    wget
    inetutils

    # Desktop notifications CLI (notify-send)
    libnotify

    # Terminal images / graphics
    chafa
    viu
    graphviz
    gifsicle

    # Archives
    p7zip

    # Task runners
    just

    # Databases
    redis
  ];
}
