{
  inputs,
  lib,
  config,
  ...
}: let
  nvidiaPackage = config.hardware.nvidia.package;
in {
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix

    # common pc
    ../../common/pc.nix

    # gpu-intel
    ../../gpu/intel
    ../../gpu/nvidia
  ];

  hardware = {
    i2c.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      # RTX 2070 works well with proprietary drivers
      modesetting.enable = true;

      # Power management (recommended for laptops, optional for desktops)
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      # Use the open source kernel module (required for RTX 50xx series, optional for others)
      # RTX 2070 can use either proprietary or open drivers
      open = true;

      # Enable nvidia-settings menu
      nvidiaSettings = true;

      # Driver version - stable is recommended
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # gpu-intel-coffee-lake
  boot.kernelParams = [
    "i915.enable_guc=2"
  ];
  hardware.intelgpu = {
    computeRuntime = "legacy";
    vaapiDriver = "intel-media-driver";
  };
  hardware.intelgpu.driver = "i915"; # uhd630

  # gpu-nvidia-rtx2070
  # enable the open source drivers if the package supports it
  # hardware.nvidia.open = lib.mkOverride 990 (nvidiaPackage ? open && nvidiaPackage ? firmware);
}
