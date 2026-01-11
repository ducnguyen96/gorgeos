{
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
          "--cmd '${lib.getExe pkgs.zsh}'"
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
