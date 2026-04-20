{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language toolchains
    nodejs_22
    python313
    uv
    rustup
    go

    # Node package managers
    pnpm
    fnm

    # Cloud / infra
    awscli2
    kubectl
    k9s

    # App navigators
    lazygit
    lazydocker
  ];
}
