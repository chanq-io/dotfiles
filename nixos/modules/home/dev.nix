{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Language toolchains
    nodejs_24
    python313
    uv
    rustc
    cargo
    rust-analyzer
    cargo-make
    go
    gopls

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

    # AI coding
    claude-code
    claude-agent-acp
    codex
    codex-acp

    # Build tools (needed by nvim plugins like telescope-fzf-native)
    gcc
    gnumake
  ];
}
