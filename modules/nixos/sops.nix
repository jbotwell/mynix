{inputs, ...}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops.defaultSopsFile = ../../secrets/secrets.yml;
  sops.defaultSopsFormat = "yml";

  sops.age.keyFile = "$HOME/.config/sops/age/keys.txt";
}
