{inputs, ...}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/john/.config/sops/age/keys.txt";
}
