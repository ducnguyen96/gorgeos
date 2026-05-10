{
  imports = [
    ./hardware-configuration.nix
  ];

  hardware = {
    i2c.enable = true;
    graphics.enable = true;
  };
}
