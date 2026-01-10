{
  config,
  lib,
  pkgs,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = {
        command = lib.concatStringsSep " " [
          (lib.getExe pkgs.tuigreet)
          "--cmd '${config.programs.hyprland.package}/bin/start-hyprland'"
          "--remember"
          "--remember-session"
          "--asterisks"
          "--time"
        ];
        user = "greeter";
      };
    };
  };
}
