{lib, ...}: let
  home = "/mnt/data/transmission";
in {
  systemd.tmpfiles.rules = [
    "d ${home}/watchdir 0755 john users"
    "d ${home}/Downloads 0755 john users"
    "d ${home}/.incomplete 0755 john users"
    "d ${home}/.config/transmission-daemon 0755 john users"
  ];

  systemd.services.transmission-daemon.after = lib.mkDefault ["network.target"];

  services.transmission = {
    enable = true;
    user = "john";
    inherit home;
    settings = {
      watch-dir-enabled = true;
      watch-dir = "${home}/watchdir";
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "192.168.1.*";
      rpc-host-whitelist = "mini";
    };
    openFirewall = true;
    openRPCPort = true;
  };
}
