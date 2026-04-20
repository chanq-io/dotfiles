{ pkgs, ... }:

{
  # Steam pulls in a 32-bit runtime and wraps itself in a FHS env. Two
  # extras: remoteplay.openFirewall for friends-over-the-internet, and
  # gamescope for a compositor that plays nicer than hyprland for fullscreen
  # games.
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    gamescopeSession.enable = true;
  };

  # 32-bit OpenGL/Vulkan for most games that aren't yet pure 64-bit.
  hardware.graphics.enable32Bit = true;
}
