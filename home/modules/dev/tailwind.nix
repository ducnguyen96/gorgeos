{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.tailwind;
in {
  options.dev.tailwind.enable = lib.mkEnableOption "tailwind, enable tailwind development toolkit";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };
}
