{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  environment.variables.NIXOS_OZONE_WL = "1";
}
