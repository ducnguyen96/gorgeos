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

  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = true;
    };

    xwayland.enable = true;
  };
}
