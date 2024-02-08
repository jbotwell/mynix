{ ... }:
let home = "/mnt/data/transmission";
in {
  # Caution: for some reason I had to create all the files it wanted in home
  # with correct permissions. watchdir,.config/transmission-daemon,Downloads
  # I would have thought nix would do that, but apparently not. Or I was doing
  # something wrong

  systemd.tmpfiles.rules = [
    "d ${home}/watchdir 0755 john users"
    "d ${home}/.config/transmission-daemon 0755 john users"
    "d ${home}/Downloads 0755 john users"
    "d ${home}/.incomplete 0755 john users"
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
