{ ... }:

{
  services = {
    syncthing = {
      enable = true;
      user = "john";
      dataDir = "/home/john";
      configDir = "/home/john/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      guiAddress = "0.0.0.0:8384";
      devices = {
        "sync-pi" = {
          id =
            "LKW3MJ5-TYKSOMM-JLJTFCJ-FWXZ7UE-PARLGUE-EBLBZUQ-FFKLW76-OXGCYAM";
        };
      };
      folders = {
        "sync" = {
          path = "/home/john/sync";
          devices = [ "sync-pi" ];
        };
        "org" = {
          path = "/home/john/org";
          devices = [ "sync-pi" ];
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 21027 22000 ];
}
