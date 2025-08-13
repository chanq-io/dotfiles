{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ starship ];
  home.file = {
    "starship.toml" = {
      source = ./starship.toml;
      target = ".config/starship.toml";
    }; 
  };

  programs.bat = {
    enable = true;
    config = { theme = "base16"; };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.jq = {
    enable = true;
  };

  programs.zsh = with pkgs; {
    enable = true;
    dotDir = "/home/cardamom/.config/zsh";

    sessionVariables = {
      RPS1 = "";
    };

    initExtra = ''
      eval "$(starship init zsh)"
    '';

    profileExtra = ''
      # Load Nix
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
    '';

    history = {
      expireDuplicatesFirst = true;
      ignoreSpace = false;
      save = 100000000;
      size = 1000000000;
    };

    shellAliases = {
      ls = "${pkgs.eza}/bin/eza -l --group-directories-first";
      l  = "${pkgs.eza}/bin/eza -l --group-directories-first";
      la = "${pkgs.eza}/bin/eza -la --group-directories-first";
    };

    plugins = [
      {
        name = "enhancd";
        file = "init.sh";
        src = fetchFromGitHub {
          owner = "babarot";
          repo = "enchancd";
          rev = "5afb4eb6ba36c15821de6e39c0a7bb9d6b0ba415";
          sha256 = "pKQbwiqE0KdmRDbHQcW18WfxyJSsKfymWt/TboY2iic=";
        };
      }
    ];
  };
}
