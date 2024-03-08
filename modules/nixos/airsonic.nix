{ ... }:

{
  services.airsonic = {
    user = "john";
    enable = true;
    port = 4040;
  };

  networking.firewall.allowedTCPPorts = [ 4040 ];
}
