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
          "--cmd 'uwsm start hyprland-session.desktop'" # Sử dụng UWSM thay vì gọi trực tiếp start-hyprland
          "--remember"
          "--remember-session"
          "--asterisks"
          "--time"
        ];
        user = "greeter";
      };
    };
  };

  security.pam.services.greetd.enableGnomeKeyring = lib.mkIf config.services.gnome.gnome-keyring.enable true;
}
