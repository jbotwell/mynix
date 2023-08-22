{ pkgs, ... }:

{
  services.airsonic = {
    enable = true;
    user = "john";
    home = "/home/john/airsonic";
    listenAddress = "0.0.0.0";
    port = 4040;
  };
}
