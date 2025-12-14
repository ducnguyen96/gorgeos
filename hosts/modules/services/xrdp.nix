{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.xrdp;
in {
  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };

    services.xrdp = {
      defaultWindowManager = "i3";
      openFirewall = true;
      audio.enable = true;
    };
  };
}
