{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # LSPs and plugin dependencies provided via Nix so they don't need
    # to be rebuilt on every machine. Plugin set itself is managed by
    # lazy.nvim out of the symlinked config below.
    extraPackages = with pkgs; [
      bash-language-server
      clang-tools
      pyright
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      yaml-language-server
      taplo
      tree-sitter
    ];

    extraPython3Packages = ps: with ps; [ pynvim ];
  };

  # Point ~/.config/nvim at the repo so lazy.nvim keeps working normally.
  # mkOutOfStoreSymlink avoids the Nix-store read-only trap that would
  # break lazy-lock.json writes and plugin installs.
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/nvim";
}
