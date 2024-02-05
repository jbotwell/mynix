{ ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Makes gopro as webcam possible
  boot.kernelModules = [ "v4l2loopback" ];
}
