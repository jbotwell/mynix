{ ... }:

{
  services = {
    syncthing = {
      enable = true;
      user = "john";
      dataDir = "/home/john/sync";
      configDir = "/home/john/sync/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      guiAddress = "0.0.0.0:8384";
      devices = {
        "sync-pi" = {
          id =
            "7PQFUFC-E6DYLCN-DBLP44G-QNTB6I4-V2WO2Y6-4OTXJPV-6IZTRCQ-DJEKSAH";
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
}
