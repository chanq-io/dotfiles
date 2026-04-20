{ ... }:

{
  services.openssh.enable = true;

  # Ship terminfo for every terminal emulator we might SSH in from
  # (ghostty, wezterm, kitty, etc.). Without this, remote sessions fail
  # with "can't find terminal definition" when TERM isn't xterm-256color.
  environment.enableAllTerminfo = true;
}
