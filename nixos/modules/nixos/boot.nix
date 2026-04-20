{ pkgs, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
      default = "saved";
      theme = "${pkgs.sleek-grub-theme.override { withStyle = "dark"; }}";
      gfxmodeEfi = "1920x1080";
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
