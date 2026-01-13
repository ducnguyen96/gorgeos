{
  pkgs,
  config,
  lib,
  ...
}: {
  environment = {
    systemPackages = with pkgs;
      [
        vim
      ]
      ++ lib.optional config.hardware.nvidia.modesetting.enable egl-wayland;
  };
}
