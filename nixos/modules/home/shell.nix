{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-autosuggestions"
        "jeffreytse/zsh-vi-mode"
        "zdharma-continuum/fast-syntax-highlighting"
        "ael-code/zsh-colored-man-pages"
        "matthiasha/zsh-uv-env"
      ];
    };

    initExtra = ''
      # Starship handles the venv indicator itself.
      export VIRTUAL_ENV_DISABLE_PROMPT=1

      # zsh-vi-mode rewrites the prompt on load, so starship must init afterwards.
      zvm_after_init() {
        eval "$(starship init zsh)"
      }

      source ~/.dotfiles/shell/aliases.zsh
      source ~/.dotfiles/shell/aliases.nixos.zsh
      source ~/.dotfiles/shell/variables.zsh
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[X](bold red)";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
