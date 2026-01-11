{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel-gen2
    inputs.disko.nixosModules.disko
    ./disko.nix
  ];
  hardware = {
    i2c.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
