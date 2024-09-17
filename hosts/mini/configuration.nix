# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/airsonic.nix
    ../../modules/nixos/jellyfin.nix
    ../../modules/nixos/lnd.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/sops.nix
    ../../modules/nixos/syncthing-lead.nix
    ../../modules/nixos/transmission.nix
    ../../modules/nixos/users.nix
    ../shared/nixos-server.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Attempt to connect to the raid array
  boot.swraid = {
    enable = true;
    mdadmConf = ''
      ARRAY /dev/md0 level=raid1 num-devices=2 UUID=b692de33-bf2b-edd3-e609-f38cf77be8eb
    '';
  };
  fileSystems."/mnt/data" = {
    device = "/dev/md0p1";
    fsType = "ext4";
    options = ["nofail"];
  };

  networking.hostName = "mini";

  environment.systemPackages = with pkgs; [git mdadm vim wget];

  system.stateVersion = "23.11";
}
