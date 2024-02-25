{ ... }:
let home = "/mnt/data/transmission";
in {
  systemd.tmpfiles.rules = [
    "d ${home}/.config/transmission-daemon 0755 john john"
    "d ${home}/.incomplete 0755 john john"
    "d ${home}/watchdir 0755 john john"
    "d ${home}/Downloads 0755 john john"
  ];
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
