{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/egpu.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/gnupg.nix
    ../../modules/nixos/keyboard.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/networks.nix
    ../../modules/nixos/npm.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/steam.nix
    ../../modules/nixos/syncthing-follow.nix
    ../../modules/nixos/trezor.nix
    ../../modules/nixos/ui.nix
    ../../modules/nixos/users.nix
  ];

  networking.hostName = "xtx";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath =
      lib.mapAttrsToList (key: value: "${key}=${value.to.path}")
      config.nix.registry;
  };

  system.stateVersion = "22.11";
}
