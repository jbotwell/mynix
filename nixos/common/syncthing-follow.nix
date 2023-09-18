{ ... }:

{
  services = {
    syncthing = {
      enable = true;
      user = "john";
      overrideDevices = true;
      overrideFolders = true;
      guiAddress = "0.0.0.0:8384";
      devices = {
        "sync-pi" = {
          id =
            "CDRP3F2-VWZDH2L-CAQZV5S-R26IXFD-V54HYEE-2KPGE52-REWJEJ5-K52U3QL";
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
