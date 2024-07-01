{
  lib,
  config,
  ...
}: {
  config.hardware.nvidia.open = lib.mkForce true;
  config.services.xserver.videoDrivers = lib.mkForce ["nouveau"];
  config.services.displayManager.sessionPackages = [config.programs.sway.package];
}
