{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    environment = {
      sessionVariables = {
        GBM_BACKEND = "nvidia";
        LIBVA_DRIVER_NAME = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      };
    };

    hardware = {
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
      };

      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    services.xserver.videoDrivers = ["nvidia"];
  };
}
