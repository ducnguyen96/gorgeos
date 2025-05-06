{
  pkgs,
  config,
  ...
}: {
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Useful other development tools
  environment.systemPackages = with pkgs; [
    podman-tui # status of containers in the terminal
    podman-compose # start group of containers for dev
  ];
  hardware.nvidia-container-toolkit.enable =
    builtins.any (
      driver: driver == "nvidia"
    )
    config.services.xserver.videoDrivers;
}
