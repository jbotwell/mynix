{ inputs, pkgs, ... }:

{
  programs.emacs.enable = true;
  programs.emacs.package = pkgs.unstable.emacsPackages.emacs;
  home.file = {
    ".config/emacs" = {
      source = inputs.doom-emacs;
      recursive = true;
    };
    ".config/doom" = {
      source = ./doom-emacs;
      recursive = true;
    };
  };
}
