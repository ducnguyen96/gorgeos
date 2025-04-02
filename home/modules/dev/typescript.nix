{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.typescript;
in {
  options.dev.typescript = {
    enable = lib.mkEnableOption "typescript, enable typescript development toolkit";
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
      ++ lib.optionals (!cfg.useMasonLSP) [vtsls]
      ++ lib.optionals (cfg.asHomePkgs) [
        nodejs_22
        pnpm
        yarn
      ];
  };
}
