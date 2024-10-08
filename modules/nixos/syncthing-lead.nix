{...}: let
  dataDir = "/syncthing";
  configDir = "${dataDir}/config";
  sync = "${dataDir}/sync";
  org = "${dataDir}/org";
  ob = "${dataDir}/ob";
  photos = "${dataDir}/photos";
  share = "${dataDir}/share";
in {
  systemd.tmpfiles.rules = [
    "d ${dataDir} 0755 john users"
    "d ${configDir} 0755 john users"
    "d ${sync} 0755 john users"
    "d ${org} 0755 john users"
    "d ${ob} 0755 john users"
    "d ${photos} 0755 john users"
    "d ${share} 0755 john users"
  ];

  networking.firewall.allowedTCPPorts = [8384 22000];
  networking.firewall.allowedUDPPorts = [22000 21027];

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
            id = "DKL2Q7P-2O4H3YZ-X7NOI3U-O5WUQPE-QARONKC-RDEXRVD-T67LGLE-JBAVAAT";
          };
          "pixel" = {
            id = "HGRGSOD-OCWFSVV-ELPXLTY-VQS4VSF-RZGDZCH-INZC2K3-CWX4RZ5-I6N5RAY";
          };
          "pixel6" = {
            id = "YPUJXVS-X2SSFOY-XI2UDIV-GUXTGYI-TH2T5Z3-DOGRRZG-SN24UUV-CTMY7QZ";
          };
          "pixel8" = {
            id = "Y3TES7W-75I3N5R-DBDV3GJ-ZNM3IOM-YTDCV4Y-7GESXNZ-FV4EUVP-C66CVAS";
          };
          "samsung-tab" = {
            id = "U4BLU3O-VGCST4Z-YFJ6NLY-UA2MT2S-AI3TAAR-KHU54VO-EBLYPDQ-EQ26LAY";
          };
          "spg" = {
            id = "E53ZNC4-KRSRXEY-UMUFKXQ-FR7I7KC-SOVJ7K2-3CDEUMG-HJRG477-DCDCOQU";
          };
          "xtx" = {
            id = "GNEQYKA-FFTEDS5-234FWUL-LDEKY4H-KF35PIO-7GQSP2Z-2J4INQK-Z5UEDAN";
          };
        };
        folders = {
          "sync" = {
            path = sync;
            devices = ["pixel" "pixel6" "fw" "samsung-tab" "spg" "xtx"];
          };
          "org" = {
            path = org;
            devices = ["pixel6" "fw" "samsung-tab" "spg" "xtx"];
          };
          "ob" = {
            path = ob;
            devices = ["pixel" "pixel6" "fw" "samsung-tab" "spg" "xtx"];
          };
          "photos" = {
            path = photos;
            devices = ["pixel"];
          };
          "share" = {
            path = share;
            devices = ["pixel" "pixel8" "xtx"];
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
