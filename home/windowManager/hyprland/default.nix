{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./config
    ./programs/waybar.nix
    ./programs/swaylock.nix
    ./programs/wofi.nix
    ./services/dunst.nix
  ];

  home.packages = with pkgs; [
    config.wayland.windowManager.hyprland.package

    xdg-utils

    dbus
    libnotify
    libcanberra-gtk3

  ];

  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = true;
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };

    xwayland.enable = true;
  };

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };

  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";
    mimeApps.enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
