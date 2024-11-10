{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.typescript;
in {
  options.dev.typescript.enable = lib.mkEnableOption "typescript, enable typescript development toolkit";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs_22
      pnpm
    ];
  };
}
