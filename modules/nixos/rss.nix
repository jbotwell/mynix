{ config, pkgs, ... }:

{
  services.tt-rss = {
    enable = true;
    virtualHost = "tt-rss.example.com";
    selfUrlPath = "https://tt-rss.example.com";
    database = {
      type = "pgsql";
      host = "localhost";
      name = "ttrss";
      user = "ttrss";
      password = "$(cat /run/secrets/ttrss_password)";
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "ttrss" ];
    ensureUsers = [
      {
        name = "ttrss";
        ensurePermissions."DATABASE ttrss" = "ALL PRIVILEGES";
      }
    ];
  };

  services.nginx = {
    enable = true;
    virtualHosts."tt-rss.example.com" = {
      forceSSL = true;
      enableACME = true;
    };
  };

  security.acme.acceptTerms = true;
  security.acme.email = "your_email@example.com";
}
}
