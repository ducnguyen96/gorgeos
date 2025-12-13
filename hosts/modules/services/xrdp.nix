{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.xrdp;
in {
  # Just configure the built-in xrdp service
  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      desktopManager.xfce.enable = true;
    };

    services.xrdp = {
      defaultWindowManager = "startxfce4";
      openFirewall = true;
    };
  };
}

