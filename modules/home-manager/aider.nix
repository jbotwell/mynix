{
  inputs,
  pkgs,
  ...
}: let
  aider = inputs.my-aider.packages.${pkgs.system}.default;
in {
  home.packages = [
    aider
  ];
}
