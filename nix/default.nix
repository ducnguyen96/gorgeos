{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./nixpkgs.nix
  ];

  nix = {
    package = pkgs.nix;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "/etc/nix/registry.json";
      trusted-users = ["root" "@wheel"];
    };
  };
}
