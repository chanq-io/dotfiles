{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    gamescopeSession.enable = true;
  };

  hardware.graphics.enable32Bit = true;

  # Patch the Steam .desktop file to remove PrefersNonDefaultGPU which
  # causes app launchers to run Steam on a secondary GPU, breaking window
  # rendering on Hyprland with multi-GPU setups.
  environment.systemPackages = [
    (pkgs.runCommand "steam-desktop-fix" { } ''
      mkdir -p $out/share/applications
      sed \
        -e '/PrefersNonDefaultGPU/d' \
        -e '/X-KDE-RunOnDiscreteGpu/d' \
        ${pkgs.steam}/share/applications/steam.desktop \
        > $out/share/applications/steam.desktop
    '')
  ];
}
