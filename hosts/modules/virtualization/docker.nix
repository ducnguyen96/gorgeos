{config, ...}: {
  virtualisation.docker = {
    enable = true;
  };
  hardware.nvidia-container-toolkit.enable =
    builtins.any (
      driver: driver == "nvidia"
    )
    config.services.xserver.videoDrivers;
}
