{
  lib,
  config,
  ...
}: {
  # common pc ssd
  services.fstrim.enable = lib.mkDefault true;

  # common pc
  boot.blacklistedKernelModules = lib.optionals (!config.hardware.enableRedistributableFirmware) ["ath3k"];

  # cpu-only
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
