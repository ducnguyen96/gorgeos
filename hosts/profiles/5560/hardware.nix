{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.dell-precision-5560
    ./hardware-configuration.nix
  ];
  hardware = {
    i2c.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
