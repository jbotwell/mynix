{...}: {
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
            id = "LXRQ76E-4ZJXS7V-QETJ4RI-XIPESSM-24YOMBJ-7OUQR36-A7O2WSD-BJ7JRQ2";
          };
        };
        folders = {
          "sync" = {
            path = "/home/john/sync";
            devices = ["mini"];
          };
          "org" = {
            path = "/home/john/org";
            devices = ["mini"];
          };
          "ob" = {
            path = "/home/john/ob";
            devices = ["mini"];
          };
          "share" = {
            path = "/home/john/share";
            devices = ["mini"];
          };
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [8384 22000];
  networking.firewall.allowedUDPPorts = [21027 22000];
}
