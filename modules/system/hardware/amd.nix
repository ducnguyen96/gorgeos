{
  config = {
    boot.initrd.kernelModules = ["amdgpu"];

    services.xserver.videoDrivers = ["amdgpu"];
  };
}
