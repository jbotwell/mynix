{ config, inputs, lib, ... }:

{
  imports = [
    ./boot.nix
    ./fonts.nix
    ./hardware-configuration.nix
    ./networks.nix
    ./overlays.nix
    ./printing.nix
    ./programs.nix
    ./sound.nix
    ./ui.nix
    ../common/locale.nix
    ../common/syncthing-follow.nix
    ../common/users.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}")
      config.nix.registry;
  };

  # networking.firewall.enable = false;

  system.stateVersion = "22.11";

}
