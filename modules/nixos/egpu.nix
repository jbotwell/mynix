{pkgs, ...}: {
  specialisation = {
    egpu = {
      inheritParentConfig = true;
      configuration = {
        boot.initrd.kernelModules = ["amdgpu"];
        boot.kernelModules = ["thunderbolt"];

        hardware.enableRedistributableFirmware = true;

        hardware.opengl.extraPackages = with pkgs; [
          rocmPackages.clr.icd
          amdvlk
        ];

        services.hardware.bolt.enable = true;

        services.xserver.videoDrivers = ["amdgpu"];

        hardware.opengl.driSupport = true;
        hardware.opengl.driSupport32Bit = true;

        services.xserver.deviceSection = ''
          Section "Device"
              Identifier "AMDGPU"
              Driver "amdgpu"
              EndSection
        '';
      };
    };
  };
}
