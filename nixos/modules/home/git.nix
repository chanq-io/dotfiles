{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Pierre Chanquion";
    userEmail = "pierre@chanq.io";
    delta.enable = true;
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
