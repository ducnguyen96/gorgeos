{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dev.aws;
in {
  options.dev.aws.enable = lib.mkEnableOption "aws, enable aws development toolkit";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      awscli2
      awsume
    ];
  };
}
