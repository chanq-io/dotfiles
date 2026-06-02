{ pkgs, inputs, ... }:

let
  # Betterbird/Thunderbird binds each profile to the binary's install path; on
  # NixOS that path changes every rebuild, so the install-hash logic spawns a
  # fresh empty profile and the real mail config "disappears". The session
  # variable below only applies at login, and the upstream flake ships a raw
  # ELF (no wrapper), so we bake the env in at the package level — this guards
  # in-session relaunches after a rebuild too. The .desktop launcher hardcodes
  # an absolute store path, so we repoint its Exec at the wrapped binary.
  bb = inputs.betterbird.packages.${pkgs.stdenv.hostPlatform.system}.betterbird;
  betterbird = pkgs.symlinkJoin {
    name = "betterbird-wrapped";
    paths = [ bb ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/betterbird \
        --set MOZ_LEGACY_PROFILES 1 \
        --set MOZ_ALLOW_DOWNGRADE 1
      rm $out/share/applications/betterbird.desktop
      cp ${bb}/share/applications/betterbird.desktop \
         $out/share/applications/betterbird.desktop
      substituteInPlace $out/share/applications/betterbird.desktop \
        --replace "${bb}/bin/betterbird" "$out/bin/betterbird"
    '';
  };
in

{
  # GUI apps installed per-user via home-manager. System-level apps (Steam,
  # 1Password GUI for polkit) live in modules/nixos/*. Community flakes
  # (zen-browser, claude-desktop) come from flake inputs threaded through
  # extraSpecialArgs in flake.nix.

  # Kept for CLI launches; the betterbird package wrapper above is the
  # authoritative fix for profile persistence across rebuilds.
  home.sessionVariables.MOZ_LEGACY_PROFILES = "1";

  home.packages = [
    pkgs.firefox
    pkgs.ungoogled-chromium
    pkgs.google-chrome
    pkgs.spotify
    pkgs.maestral-gui
    pkgs.zoom-us
    pkgs.libreoffice-qt6-fresh
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.claude-desktop.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop
    betterbird
  ];
}
