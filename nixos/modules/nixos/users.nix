{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users.cardamom = {
    isNormalUser = true;
    description = "Pierre Chanquion";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };
}
