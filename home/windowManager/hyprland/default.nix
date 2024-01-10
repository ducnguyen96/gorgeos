{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./config
  ];
  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = true;
    };

    xwayland.enable = true;
  };
}
