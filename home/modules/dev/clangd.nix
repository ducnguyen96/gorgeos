{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.clangd;
in {
  options.dev.clangd = {
    enable = lib.mkEnableOption "c, enable c development toolkit";
    useMasonLSP = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to use Mason to install lsp package";
    };
    asHomePkgs = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install development pkgs as home pkgs so that it can be reused anywhere without a dev shell";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      []
      ++ lib.optionals (cfg.asHomePkgs) [gcc15 bear clang-tools];
  };
}
