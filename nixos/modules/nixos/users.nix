{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users.cardamom = {
    isNormalUser = true;
    description = "Pierre Chanquion";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };
}
