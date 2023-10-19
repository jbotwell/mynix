{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbOptions = "ctrl:swapcaps";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # keyring
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [ gnomeExtensions.forge ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
}
