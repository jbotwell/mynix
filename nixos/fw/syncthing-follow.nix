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
      settings = {
        devices = {
          "mini" = {
            id =
              "VDZLNSC-LNQ74VR-BDXDRZC-RVQDM3H-LQ4VYH7-BFXUHT5-HAAKBD6-TKSYRAP";
          };
        };
        folders = {
          "sync" = {
            path = "/home/john/sync";
            devices = [ "mini" ];
          };
          "org" = {
            path = "/home/john/org";
            devices = [ "mini" ];
          };
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 21027 22000 ];
}
