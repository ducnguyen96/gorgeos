{
  config,
  lib,
  ...
}: {
  environment = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };

  config = {
    hardware = {
      nvidia = {
        modesetting.enable = true;
        open = false;
      };

      graphics = {
        enable = true;
      };
    };

    services.xserver.videoDrivers = ["nvidia"];
  };
}
