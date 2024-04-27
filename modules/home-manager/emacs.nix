{ inputs, pkgs, ... }:

{
  programs.emacs.enable = true;
  programs.emacs.package = pkgs.unstable.emacsPackages.emacs;
  home.file = {
    ".config/emacs" = {
      src = inputs.doom-emacs;
      recursive = true;
    };
    ".config/doom" = {
      src = ./doom-emacs;
      recursive = true;
    };
  };
}
