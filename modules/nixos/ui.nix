{pkgs, ...}: {
  services = {
    gnome.gnome-keyring.enable = true;
    udev.packages = with pkgs; [gnome.gnome-settings-daemon];
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
