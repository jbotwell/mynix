{ config, inputs, lib, ... }:

{
  imports = [
    ./boot.nix
    ./fonts.nix
    ./gnupg.nix
    ./hardware-configuration.nix
    ./networks.nix
    ./npm.nix
    ../../overlays/overlays.nix
    ./printing.nix
    ./sound.nix
    ./trezor.nix
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

  system.stateVersion = "22.11";

  specialization = {
    laptop = { inheritParentConfig = true; };

    egpu = {
      inheritParentConfig = true;
      configuration = {
        boot.kernelModules = [ "thunderbolt" "amdgpu" ];
        services.udev.packages = [ pkgs.linuxPackages_amd.thunderbolt ];

        hardware.enableRedistributableFirmware = true;

        hardware.opengl.extraPackages = with pkgs; [ linuxPackages_amd.amdgpu ];

        services.bolt.enable = true;
        services.bolt.policy = "auto";

        services.xserver.deviceSection = ''
          Section "Device"
              Identifier "AMDGPU"
              Driver "amdgpu"
              EndSection
        '';
      };
    };
  };
}
