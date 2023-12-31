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
        "media-pi" = {
          id =
            "D5COXVH-AF5OUSS-N7A34JK-37ZXNM7-7BQBQRP-SRYTZYG-WIOEYXO-5CT4CQ3";
        };
        "spg" = {
          id =
            "E53ZNC4-KRSRXEY-UMUFKXQ-FR7I7KC-SOVJ7K2-3CDEUMG-HJRG477-DCDCOQU";
        };
        "samsung-tab" = {
          id =
            "U4BLU30-VGCST4Z-YFJ6NLY-UA2MT2S-AI3TAAR-KHU54V0-EBLYPDQ-EQ26LAY";
        };
      };
      folders = {
        "sync" = {
          path = "/home/john/sync";
          devices = [ "pixel" "fw" "media-pi" "samsung-tab" "spg" ];
        };
        "org" = {
          path = "/home/john/org";
          devices = [ "pixel" "fw" "media-pi" "samsung-tab" "spg" ];
        };
      };
    };
  };
}
