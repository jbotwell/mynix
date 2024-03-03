{ ... }:
let
  dataDir = "/syncthing";
  configDir = "${dataDir}/config";
  sync = "${dataDir}/sync";
  org = "${dataDir}/org";
in {
  systemd.tmpfiles.rules = [
    "d ${dataDir} 0755 john users"
    "d ${configDir} 0755 john users"
    "d ${sync} 0755 john users"
    "d ${org} 0755 john users"
  ];

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

  services = {
    syncthing = {
      inherit dataDir configDir;
      enable = true;
      user = "john";
      overrideDevices = true;
      overrideFolders = true;
      guiAddress = "0.0.0.0:8384";
      settings = {
        devices = {
          "fw" = {
            id =
              "547RYKF-VZCNPLZ-F5TCQY7-LUOLRLK-KM2KUBU-4RJNIMB-P7KBHFG-7BNUSQM";
          };
          "pixel" = {
            id =
              "YPUJXVS-X2SSFOY-XI2UDIV-GUXTGYI-TH2T5Z3-DOGRRZG-SN24UUV-CTMY7QZ";
          };
          "samsung-tab" = {
            id =
              "U4BLU3O-VGCST4Z-YFJ6NLY-UA2MT2S-AI3TAAR-KHU54VO-EBLYPDQ-EQ26LAY";
          };
          "spg" = {
            id =
              "E53ZNC4-KRSRXEY-UMUFKXQ-FR7I7KC-SOVJ7K2-3CDEUMG-HJRG477-DCDCOQU";
          };
        };
        folders = {
          "sync" = {
            path = sync;
            devices = [ "pixel" "fw" "samsung-tab" "spg" ];
          };
          "org" = {
            path = org;
            devices = [ "pixel" "fw" "samsung-tab" "spg" ];
          };
        };
        gui = {
          user = "john.otwell";
          # bcrypt
          password = "$2y$10$cKvo2rJLj5vzHdgPpEhrtu4gmdUCCZ0LvahBeKGA/b8oljK6cyHHO";
        };
      };
    };
  };
}
