{ pkgs, ... }:

{
  systemd.services.jellyfin = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = [ "Jellyfin" ];
    serviceConfig = {
      Type = "simple";
      User = "john";
      ExecStart = "${pkgs.jellyfin}/bin/jellyfin --service";
      Restart = "always";
    };
  };

  environment.systemPackages = [ pkgs.jellyfin ];
}
