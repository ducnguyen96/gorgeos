{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.clangd;
in {
  options.dev.clangd.enable = lib.mkEnableOption "c, enable c development toolkit";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };
}
