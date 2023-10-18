{ pkgs, ... }:

{
  home.packages = with pkgs; [ dotnet-sdk_7 ];
  programs.bash.sessionVariables = { DOTNET_ROOT = "${pkgs.dotnet-sdk_7}"; };
}
