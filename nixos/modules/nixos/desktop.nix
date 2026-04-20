{ ... }:

{
  programs.hyprland.enable = true;

  environment.loginShellInit = ''
    if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = "1" ]; then
      exec Hyprland
    fi
  '';
}
