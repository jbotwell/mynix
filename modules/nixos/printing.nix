{pkgs, ...}: {
  services.printing.enable = true;
  services.printing.drivers = [pkgs.brlaser];
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;
  # note to self: cups web gui is at port 631
}
