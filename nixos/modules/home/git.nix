{ ... }:

{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  # No git integration: delta stays the default pager, difftastic is
  # opt-in via `git dft` / `git dlog` (mirrors macos/git/gitconfig).
  programs.difftastic.enable = true;

  programs.git = {
    enable = true;
    ignores = [ ".envrc" ];
    settings = {
      user.name = "Pierre Chanquion";
      user.email = "pierre@chanq.io";
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      delta = {
        navigate = true;
        line-numbers = true;
      };
      merge.conflictStyle = "zdiff3";
      diff.tool = "difftastic";
      difftool.prompt = false;
      difftool."difftastic".cmd = ''difft "$LOCAL" "$REMOTE"'';
      pager.difftool = true;
      alias = {
        dft = "difftool";
        dlog = "!GIT_EXTERNAL_DIFF=difft git log -p --ext-diff";
      };
    };
  };
}
