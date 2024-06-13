{
  inputs,
  pkgs,
  ...
}: let
  aider = inputs.aider-flake.packages.${pkgs.system}.default;
in {
  home.packages = [
    aider
  ];
}
