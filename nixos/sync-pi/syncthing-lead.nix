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
        "pixel" = {
          id =
            "V7HUVHP-MNB6POZ-I6SGZ6E-2ITVOLD-VYIB7QW-Z4JA5TL-77CA4W2-UJOY7AY";
        };
        "fw" = {
          id =
            "YZ7ERYB-HOCHEQM-5RJM5DW-7WS4ZZE-3JTQ3XW-JJ3MLUX-NB456I2-BGJFFQZ";
        };
        "media-pi" = {
          id =
            "OD3R4RA-IAA4SXH-PZ3G2MP-5WC7OUS-ZPSAPYE-EEC4WBZ-46IJB2O-5GIRPQZ";
        };
      };
      folders = {
        "sync" = {
          path = "/home/john/sync";
          devices = [ "pixel" "fw" "media-pi" ];
        };
        "org" = {
          path = "/home/john/org";
          devices = [ "pixel" "fw" "media-pi" ];
        };
      };
    };
  };
}
