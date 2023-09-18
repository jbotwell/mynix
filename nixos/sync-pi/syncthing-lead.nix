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
        "pixel" = {
          id =
            "V7HUVHP-MNB6POZ-I6SGZ6E-2ITVOLD-VYIB7QW-Z4JA5TL-77CA4W2-UJOY7AY";
        };
        "fw" = {
          id =
            "ZR54MKY-6TIARLI-MQBUIEP-ZKYONIM-7345LU7-QHWQPSL-SGPWQGQ-Y2DEHQH";
        };
      };
      folders = {
        "sync" = { # Name of folder in Syncthing, also the folder ID
          path = "/home/john/sync"; # Which folder to add to Syncthing
          devices = [ "pixel" "fw" ]; # Which devices to share the folder with
        };
        "org" = {
          path = "/home/john/org";
          devices = [ "pixel" "fw" ];
        };
      };
    };
  };
}
