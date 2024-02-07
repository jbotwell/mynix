{ pkgs, ... }:

{
  programs.emacs.enable = true;
  programs.emacs.package = pkgs.unstable.emacsPackages.emacs;
}
