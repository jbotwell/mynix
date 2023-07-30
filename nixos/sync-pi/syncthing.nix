{ ... }:

{
  services = {
    syncthing = {
      enable = true;
      # dataDir = "/home/john/sync";
      # configDir = "/home/john/sync/.config/syncthing";
      # overrideDevices = true;
      # overrideFolders = true;
      guiAddress = "0.0.0.0:8384";
      extraOptions.gui = {
        user = "john";
        password =
          "sha256:2eabb82418d1665d6adfa8b9b60ddb752c000f95470436fdb66b0442255b7f66";
      };
      # devices = {
      # "pixel" = {
      # id =
      # "V7HUVHP-MNB6POZ-I6SGZ6E-2ITVOLD-VYIB7QW-Z4JA5TL-77CA4W2-UJOY7AY";
      # };
      # "fw" = {
      # id =
      # "2XTRIZJ-H53W4R3-AZTV7YL-4KT6ETR-54LF5HM-KT6VWFT-QAG7TMI-MG73PAC";
      # };
      # };
      # folders = {
      # "sync" = { # Name of folder in Syncthing, also the folder ID
      # path = "/home/john/sync"; # Which folder to add to Syncthing
      # devices = [ "pixel" "fw" ]; # Which devices to share the folder with
      # };
      # "org" = {
      # path = "/home/john/org";
      # devices = [ "pixel" "fw" ];
      # };
      # };
    };
  };
}
