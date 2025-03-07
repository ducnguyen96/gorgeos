{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.php;
in {
  options.dev.php.enable = lib.mkEnableOption "php, enable php development toolkit";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      php
    ];
  };
}
