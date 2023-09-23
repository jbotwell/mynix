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
        "pixel" = {
          id =
            "QU3WGRO-2GEGWKI-5SGDSSL-EU564OU-36MCRBC-CPX04RJ-0TMWMBX-EAZGTQV";
        };
        "fw" = {
          id =
            "547RYKF-VZCNPLZ-F5TCQY7-LUOLRLK-KM2KUBU-4RJNIMB-P7KBHFG-7BNUSQM";
        };
        #   "media-pi" = {
        #     id =
        #       "OD3R4RA-IAA4SXH-PZ3G2MP-5WC7OUS-ZPSAPYE-EEC4WBZ-46IJB2O-5GIRPQZ";
        #   };
      };
      folders = {
        "sync" = {
          path = "/home/john/sync";
          devices = [ "pixel" "fw" ];
        };
        "org" = {
          path = "/home/john/org";
          devices = [ "pixel" "fw" ];
        };
      };
    };
  };
}
