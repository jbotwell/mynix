{
  pkgs,
  config,
  ...
}: let
  ctags-hook = pkgs.writeShellScript "ctags-hook.sh" ''
    git ls-files | ctags -f .git/.tags --tag-relative -L -
  '';
  email =
    if config.home.username == "john_otwell"
    then "john.otwell@spglobal.com"
    else "john.otwell@proton.me";
in {
  home.packages = with pkgs; [universal-ctags];
  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "John Otwell";
    userEmail = email;
    hooks = {
      post-commit = ctags-hook;
      post-checkout = ctags-hook;
      post-merge = ctags-hook;
      post-rewrite = pkgs.writeShellScript "ctags-rewrite-hook.sh" ''
        case "$1" in
          rebase) git ls-files | ctags -f .git/.tags --tag-relative -L - ;;
        esac
      '';
    };
    extraConfig = {
      core.editor = "vim";
      merge.conflictStyle = "diff3";
      diff.colorMoved = "default";
      merge.tool = "nvimdiff";
      pull.rebase = false;
      init.defaultBranch = "main";
      delta.side-by-side = true;
      delta.line-numbers = true;
    };
  };
}
