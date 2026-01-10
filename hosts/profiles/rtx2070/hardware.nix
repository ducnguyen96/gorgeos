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

  hardware.i2c.enable = true;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

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
  hardware.nvidia.open = lib.mkOverride 990 (nvidiaPackage ? open && nvidiaPackage ? firmware);
}
