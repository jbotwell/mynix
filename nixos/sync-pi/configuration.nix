# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./syncthing.nix
  ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "sync-pi"; # Define your hostname.

  time.timeZone = "America/New_York";

  users.users.john = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
    hashedPassword = "$6$osTnlkRhKWgV3Boa$J6EhTtFPdswyNgHW3HdDUWCNOM5xIWfvU3QppVzFwffKqCugv/Rk3fTIrAaJt9ZOEl/EraF.SoIR5lXqjQCRg.";
  };

  environment.systemPackages = with pkgs; [ git vim syncthing wget ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

  system.stateVersion = "23.11"; # Did you read the comment?

}
