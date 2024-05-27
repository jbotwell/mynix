{pkgs, ...}: {
  systemd.services.jellyfin = {
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    description = "Jellyfin";
    serviceConfig = {
      Type = "simple";
      User = "john";
      ExecStart = "${pkgs.jellyfin}/bin/jellyfin --service";
      Restart = "always";
    };
  };

  environment.systemPackages = [pkgs.jellyfin];

  networking.firewall.allowedTCPPorts = [8096 8920];
  networking.firewall.allowedUDPPorts = [1900 7359];
}
