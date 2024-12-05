{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.vue;
in {
  options.dev.vue.enable = lib.mkEnableOption "vue, enable vue development toolkit";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };
}
