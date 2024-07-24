{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf versionOlder;

  nvStable = config.boot.kernelPackages.nvidiaPackages.stable.version;
  nvBeta = config.boot.kernelPackages.nvidiaPackages.beta.version;

  nvidiaPackages =
    if (versionOlder nvBeta nvStable)
    then config.boot.kernelPackages.nvStable.stable
    else config.boot.kernelPackages.nvidiaPackages.beta;
in {
  config = {
    environment = {
      sessionVariables = {
        GBM_BACKEND = "nvidia";
        LIBVA_DRIVER_NAME = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 1;
      };
    };

    hardware = {
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;

        package = nvidiaPackages;
      };
    };

    services.xserver.videoDrivers = ["nvidia"];
  };
}
