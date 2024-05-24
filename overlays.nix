{inputs, ...}: {
  nixpkgs = {
    overlays = [
      (self: super: {
        pkgs23 = import inputs.pkgs23 {
          system = super.system;
          config = super.config;
        };
      })
    ];
  };
}
