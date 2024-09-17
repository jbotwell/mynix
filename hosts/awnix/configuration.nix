{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../shared/nixos-server.nix
    ../../modules/nixos/syncthing-lead.nix
    ../../modules/nixos/lnd.nix
    ../../modules/nixos/rss.nix
  ];

  environment.systemPackages = with pkgs; [git vim wget];
}
