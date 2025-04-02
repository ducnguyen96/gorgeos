{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.rust;
in {
  options.dev.rust = {
    enable = lib.mkEnableOption "rust, enable rust development toolkit";
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
      ++ lib.optionals (!cfg.useMasonLSP) [rust-analyzer]
      ++ lib.optionals (cfg.asHomePkgs) [cargo rustc];
  };
}
