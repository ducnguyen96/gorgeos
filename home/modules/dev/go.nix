{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.go;
in {
  options.dev.go.enable = lib.mkEnableOption "go, enable go development toolkit";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      air
      go
    ];
  };
}
