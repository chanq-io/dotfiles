{ pkgs, inputs, ... }:

{
  # GUI apps installed per-user via home-manager. System-level apps (Steam,
  # 1Password GUI for polkit) live in modules/nixos/*. Community flakes
  # (zen-browser, claude-desktop) come from flake inputs threaded through
  # extraSpecialArgs in flake.nix.

  # Betterbird/Thunderbird otherwise binds profiles to the install path; on
  # NixOS that path changes every rebuild, spawning a fresh empty profile.
  home.sessionVariables.MOZ_LEGACY_PROFILES = "1";

  home.packages = [
    pkgs.firefox
    pkgs.ungoogled-chromium
    pkgs.google-chrome
    pkgs.spotify
    pkgs.maestral-gui
    pkgs.zoom-us
    pkgs.onlyoffice-desktopeditors
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.claude-desktop.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop
    inputs.betterbird.packages.${pkgs.stdenv.hostPlatform.system}.betterbird
  ];
}
