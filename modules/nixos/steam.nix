{pkgs, ...}: {
  services.xserver.videoDrivers = ["amdgpu"];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    protonup
    mangohud
  ];
}
