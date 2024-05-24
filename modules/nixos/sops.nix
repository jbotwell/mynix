{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  environment.systemPackages = [pkgs.sops];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/john/.config/sops/age/keys.txt";
  sops.secrets = let
    me = "john";
  in {
    openai_key.owner = me;
    openrouter_key.owner = me;
    pplx_key.owner = me;
    anthropic_key.owner = me;
  };
}
