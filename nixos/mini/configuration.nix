# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common/users.nix
  ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  # Attempt to connect to the raid array
  boot.initrd.mdadmConf = ''
    ARRAY /dev/md0 level=raid1 num-devices=2 UUID=b692de33-bf2b-edd3-e609-f38cf77be8eb
  '';

  fileSystems."/mnt/data" = {
    device = "/dev/md0";
    fsType = "ext4";
    options = [ "nofail" "noauto" ];
  };

  networking.hostName = "mini";

  time.timeZone = "America/New_York";

  environment.systemPackages = with pkgs; [ git vim wget ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 4040 8096 8920 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 1900 7359 22000 21027 ];

  system.stateVersion = "23.11";
}
