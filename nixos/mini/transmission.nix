{ pkgs, ... }:

{
  services.transmission = {
    enable = true;
    user = "john";
    home = "/home/john";
    settings = {
      watch-dir-enabled = true; # should be <home>/watchdir by default
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "192.168.1.*";
      rpc-host-whitelist = "media-pi";
    };
    openFirewall = true;
    openRPCPort = true;
  };
}
