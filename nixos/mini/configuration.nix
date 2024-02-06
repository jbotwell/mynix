# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./syncthing-lead.nix
    ../common/users.nix
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
    options = [ "nofail" ];
  };

  networking.hostName = "mini";

  time.timeZone = "America/New_York";

  environment.systemPackages = with pkgs; [ git mdadm vim wget ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 4040 8096 8920 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 1900 7359 22000 21027 ];

  services = {
    syncthing = {
      enable = true;
      user = "john";
      dataDir = "/home/john";
      configDir = "/home/john/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      guiAddress = "0.0.0.0:8384";
      settings = {
        devices = {
          "pixel" = {
            id =
              "QU3WGRO-2GEGWKI-5SGDSSL-EU564OU-36MCRBC-CPX04RJ-0TMWMBX-EAZGTQV";
          };
          "fw" = {
            id =
              "547RYKF-VZCNPLZ-F5TCQY7-LUOLRLK-KM2KUBU-4RJNIMB-P7KBHFG-7BNUSQM";
          };
          "spg" = {
            id =
              "E53ZNC4-KRSRXEY-UMUFKXQ-FR7I7KC-SOVJ7K2-3CDEUMG-HJRG477-DCDCOQU";
          };
          "samsung-tab" = {
            id =
              "U4BLU30-VGCST4Z-YFJ6NLY-UA2MT2S-AI3TAAR-KHU54V0-EBLYPDQ-EQ26LAY";
          };
        };
        folders = {
          "sync" = {
            path = "/home/john/sync";
            devices = [ "pixel" "fw" "samsung-tab" "spg" ];
          };
          "org" = {
            path = "/home/john/org";
            devices = [ "pixel" "fw" "samsung-tab" "spg" ];
          };
        };
      };
    };
  };

  system.stateVersion = "23.11";
}
