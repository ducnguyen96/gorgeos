{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./run-as-service.nix
    ./wofi-power.nix
    ./rebuild.nix
  ];
}
