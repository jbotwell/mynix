{pkgs, ...}: {
  systemd.services.jellyfin = {
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    description = "Jellyfin";
    serviceConfig = {
      Type = "simple";
      User = "john";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 20";
      ExecStart = "${pkgs.jellyfin}/bin/jellyfin --service";
      Restart = "always";
      StandardOutput = "syslog";
      StandardError = "syslog";
    };
  };

  environment.systemPackages = [pkgs.jellyfin];

  networking.firewall.allowedTCPPorts = [8096 8920];
  networking.firewall.allowedUDPPorts = [1900 7359];
}
