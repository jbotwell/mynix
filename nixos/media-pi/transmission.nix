{ pkgs, ... }:

{
  services.transmission = {
    enable = true;
    home = "/home/john/";
    settings = {
      watch-dir-enabled = true; # should be <home>/watchdir by default
    };
  };
}
