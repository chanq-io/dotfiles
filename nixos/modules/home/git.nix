{ ... }:

{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

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
    };
  };
}
