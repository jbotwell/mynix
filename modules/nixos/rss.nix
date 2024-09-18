{pkgs, ...}: let
  ttrss = "ttrss";
in {
  services.tt-rss = {
    enable = true;
    virtualHost = "rss.otwell.dev";
    selfUrlPath = "https://rss.otwell.dev";
    database = {
      type = "pgsql";
      host = "localhost";
      name = ttrss;
      user = ttrss;
      createLocally = false;
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ttrss];
    ensureUsers = [
      {
        name = ttrss;
        ensureDBOwnership = true;
      }
    ];
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
  };

  services.nginx = {
    enable = true;
    virtualHosts."rss.otwell.dev" = {
      forceSSL = true;
      enableACME = true;
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "john.otwell@proton.me";
}
