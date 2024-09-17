{
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  users.users."john".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5kxu04jD38NE8cFiW4Ip1qi4xTiNRg5PWAFJS5gl8O john@nixos"
  ];

  # Experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Open ports in the firewall
  networking.firewall.allowedTCPPorts = [22];
}
