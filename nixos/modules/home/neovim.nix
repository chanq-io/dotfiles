{ pkgs, config, lib, ... }:

let
  # Each entry: query repo at neovim-treesitter/nvim-treesitter-queries-<name>
  # (the community successor to the archived nvim-treesitter org) + parser
  # from pkgs.tree-sitter-grammars.<grammar>. Revs pinned to specific query
  # commits so fetches are reproducible; hashes computed on first build.
  langs = [
    { name = "bash";            grammar = "tree-sitter-bash";             rev = "6e198671f2e8de504c2099f92d52cc2a68f13410"; hash = "sha256-zL/IvrmZY/HxpbbzEosjLHJc470n3OmzaxjaKQe81Oc="; }
    { name = "c";               grammar = "tree-sitter-c";                rev = "dcbcbe7c941b926a94583bee889537e920bdf7f6"; hash = "sha256-WioCdlMX7NiEeBAPHh3ZC4obCeDMXzaF0ykoXxKDv7M="; }
    { name = "cmake";           grammar = "tree-sitter-cmake";            rev = "76165ec8a85e317cf790e318f181571e267670e7"; hash = "sha256-Tf7yO7+EqqClspQ+sr+TPHBQAJLzZqhEWTNHKsDQyfg="; }
    { name = "cpp";             grammar = "tree-sitter-cpp";              rev = "c6f6501320c5ecbcb4e08805e711027fc00fc365"; hash = "sha256-hqxUgj4Rvm3sya0WHfhXuZDR0aHHgiv3YBhTulbv7KU="; }
    { name = "css";             grammar = "tree-sitter-css";              rev = "f6c9bcb9b8c9ee0189ea01f858875860b524dd80"; hash = "sha256-76rlyCMvk9qbqsFEt46WDwHWHYzJuOqc6s/l1EZE0FY="; }
    { name = "dockerfile";      grammar = "tree-sitter-dockerfile";       rev = "50e509c71602145de7b383675c3811ac5190ddb4"; hash = "sha256-J6vP4vWgZtZ9ddkRrAZM6BP9xxdgeRmoZjKF+fxzFHY="; }
    { name = "go";              grammar = "tree-sitter-go";               rev = "90ad6c7104390f9373a4a6fabe2da9e90f891252"; hash = "sha256-OCO0F9Zj5fDgFvHp81Nxd12AsHliZcnFv2lk+VI/Mao="; }
    { name = "html";            grammar = "tree-sitter-html";             rev = "9d72f6d2983e4d523156f21e927d2c92adcaf003"; hash = "sha256-h8fYk2/hdpVe0ffmTKvRx/K0VY1w8wAGa98WcbRkKgs="; }
    { name = "javascript";      grammar = "tree-sitter-javascript";       rev = "60cc37d9acbb83b7a8b988a6221920806ac648e6"; hash = "sha256-whdG3IhRRERBc1v6QQTGujXyKem7Co2K42/XmEdprlk="; }
    { name = "json";            grammar = "tree-sitter-json";             rev = "26578bdf15e56b4e565c92edcc021665d41c6ca4"; hash = "sha256-Pa4qU5pPNyY0DPYN4YdLVL9vsVOhNTKQ/joH4cT97us="; }
    { name = "markdown";        grammar = "tree-sitter-markdown";         rev = "adc2014ec864d3edb5281bae89b9784073a80441"; hash = "sha256-W+ePU3TyoBYV+F7GoeGlJXu1Tky6H/gmsnZ0OdS58Hw="; }
    { name = "markdown_inline"; grammar = "tree-sitter-markdown-inline";  rev = "f8254e287e30910966011ceff06a5912449395bc"; hash = "sha256-OWVVs5C/pb5v+F1yLJqzkuxNQi2EyyQdVWJFrt3Bu7E="; }
    { name = "nix";             grammar = "tree-sitter-nix";              rev = "7a5f60a94e8d22fc48b0f748a5a5b3e9c00ab7ba"; hash = "sha256-OFJQHQmKDwcyTq9E6mXaIZcJHfn3N0BZdDrX0tMd6YU="; }
    { name = "python";          grammar = "tree-sitter-python";           rev = "c0cde822ca01632f282eefcd5a1103aa2017e01a"; hash = "sha256-esS86Zp8+6YHwHlJxyfSYb2QYQwv4LjvK1EGzai64pE="; }
    { name = "rust";            grammar = "tree-sitter-rust";             rev = "8c2310323793ca2c70fd256095d867c40b928e44"; hash = "sha256-whfwSyFDPVS7dsnmgeO8ipFoKdXsDrFOeI/LkPXCZRc="; }
    { name = "toml";            grammar = "tree-sitter-toml";             rev = "c99be527af8a6de0cdeb57112f88d9d0be596a81"; hash = "sha256-+anF3osZ99ZaKPeTtgkjUA5VmiR2VR/WeII4qxX10xE="; }
    { name = "tsx";             grammar = "tree-sitter-tsx";              rev = "35593fbb9fa4bf384108d5dfa4e27e57a6025443"; hash = "sha256-bGWC8PmTYDsKo7PK4J+F7PRGH5ByheZg78KlNfuT1HE="; }
    { name = "typescript";      grammar = "tree-sitter-typescript";       rev = "a0659042394b37f5b952b57574e8bd79dc4aa20d"; hash = "sha256-qLeB8Od/VqlAlLYZSxmB9uCyUIT2tGwoxcSBHQW8J5o="; }
    { name = "yaml";            grammar = "tree-sitter-yaml";             rev = "5bba7d65a4bc1b586d5edb3b3c92fe6030bac843"; hash = "sha256-Byqvu7nVRuEG+kEGys3QA3zd2TKodz8ogBHuZnoq7R0="; }
  ];

  queriesFor = lang:
    pkgs.fetchFromGitHub {
      name = "queries-${lang.name}";
      owner = "neovim-treesitter";
      repo = "nvim-treesitter-queries-${lang.name}";
      inherit (lang) rev hash;
    };

  parserFor = lang: pkgs.tree-sitter-grammars.${lang.grammar};

  filesForLang = lang: [
    {
      name = "nvim/site/parser/${lang.name}.so";
      value.source = "${parserFor lang}/parser";
    }
    {
      name = "nvim/site/queries/${lang.name}";
      value.source = "${queriesFor lang}/queries";
    }
  ];
in
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
      texlab
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

  # Install tree-sitter parsers and queries into neovim's site dir.
  # Parsers come from nixpkgs tree-sitter-grammars; queries come from
  # neovim-treesitter/nvim-treesitter-queries-<lang> (community project
  # filling the gap left by the archived nvim-treesitter repo).
  xdg.dataFile = lib.listToAttrs (lib.concatMap filesForLang langs);
}
