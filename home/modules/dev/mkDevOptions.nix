{lib}: {
  mkDevOptions = toolName: extraOptions:
    {
      enable = lib.mkEnableOption "${toolName}, enable ${toolName} development toolkit";

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
    }
    // extraOptions;
}
