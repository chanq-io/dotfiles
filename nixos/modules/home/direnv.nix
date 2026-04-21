{ ... }:

{
  # Per-directory environments, with nix-direnv so `use flake` caches the
  # flake evaluation and dev shells load near-instantly. zsh integration
  # hooks `_direnv_hook` into precmd so .envrc loads on every cd.
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
