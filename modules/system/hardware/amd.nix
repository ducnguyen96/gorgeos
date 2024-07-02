{
  boot.initrd.kernelModules = ["amdgpu"];

  config = {
    environment = {
      sessionVariables = {
        ROC_ENABLE_PRE_VEGA = "1";
      };
    };

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };

  services.xserver.enable = true;
  services.xserver.videoDrivers = ["amdgpu"];
}
