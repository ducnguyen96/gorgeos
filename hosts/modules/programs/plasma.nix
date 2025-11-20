{
  # Enable KDE Plasma 6
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  environment.variables.NIXOS_OZONE_WL = "1";
}
