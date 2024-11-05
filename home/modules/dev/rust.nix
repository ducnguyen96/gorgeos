{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.rust;
in {
  options.dev.rust.enable = lib.mkEnableOption "rust, enable rust development toolkit";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      cargo
      rustc
    ];
  };
}
