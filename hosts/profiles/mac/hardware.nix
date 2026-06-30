{
  imports = [
    ./hardware-configuration.nix
  ];

  hardware = {
    graphics.enable = true;
    parallels.enable = true;
  };
}
