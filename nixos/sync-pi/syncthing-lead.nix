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
            "YO3BOTJ-WYJQHVH-FEDKETO-SF4DNYL-AWBJCWO-QE5PKZH-XNUCPAH-I3OF3A6";
        };
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
