{ pkgs, ... }:

{
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;

  # Note to self: using CUPS (localhost:631), the ipp protocol should be used
  # with the ip address of the printer and the driver `ipp everywhere`
  # 
  # I don't know of a great declarative way to do this, but that can be a TODO
  # if I want to spend the time
}
