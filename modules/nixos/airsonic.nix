{...}: let
  listenPort = 8097;
in {
  services.airsonic = {
    enable = true;
    listenAddress = "0.0.0.0";
    port = listenPort;
  };

  networking.firewall.allowedTCPPorts = [listenPort];
}
