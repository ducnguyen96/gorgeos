{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.python;
in {
  options.dev.python.enable = lib.mkEnableOption "python, enable python development toolkit";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };
}
