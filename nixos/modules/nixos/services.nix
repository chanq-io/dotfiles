{ pkgs, ... }:

{
  services.openssh.enable = true;

  # Ship terminfo for every terminal emulator we might SSH in from
  # (ghostty, wezterm, kitty, etc.). Without this, remote sessions fail
  # with "can't find terminal definition" when TERM isn't xterm-256color.
  environment.enableAllTerminfo = true;

  # Docker daemon. User is added to the docker group in users.nix so
  # everyday container work doesn't need sudo.
  virtualisation.docker.enable = true;

  # greetd + tuigreet replace the auto-exec-Hyprland-from-login-shell flow.
  # Gives a proper login prompt on tty1 and keeps the PAM session owned by
  # the right user. --cmd is the compositor to launch on successful login.
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # 1Password GUI + CLI. GUI needs polkit integration so 1Password-CLI can
  # authorise unlock via the GUI (biometric / system password). The CLI
  # alone also works via account sign-in, but polkit enables the
  # `op eval ...` workflow inheriting GUI unlock state.
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "cardamom" ];
  };
}
