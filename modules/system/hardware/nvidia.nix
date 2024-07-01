{
  config,
  lib,
  ...
}: {
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
