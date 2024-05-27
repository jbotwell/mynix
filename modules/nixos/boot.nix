{pkgs, ...}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # touchpad issues
  boot.kernelParams = ["psmouse.synaptics_intertouch=0"];
}
