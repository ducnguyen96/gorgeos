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
  ];

  home.packages = with pkgs; [
    config.wayland.windowManager.hyprland.package

    xdg-utils
  ];

  programs.rofi.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = true;
    };

    xwayland.enable = true;
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
