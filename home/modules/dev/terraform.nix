{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.terraform;
in {
  options.dev.terraform.enable = lib.mkEnableOption "terraform, enable terraform development toolkit";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };
}
