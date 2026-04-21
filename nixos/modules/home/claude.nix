{ config, ... }:

{
  # Symlink the global agents file so Claude Code picks it up automatically.
  # mkOutOfStoreSymlink keeps it pointing at the repo, so edits take effect
  # immediately without a rebuild.
  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/agents/GLOBAL_AGENTS.md";
}
