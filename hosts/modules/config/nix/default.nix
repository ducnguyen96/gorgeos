{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./nixpkgs.nix
    ./substituters.nix
  ];

  # we need git for flakes
  environment.systemPackages = [pkgs.git];

  nix = let
    flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
  in {
    package = pkgs.lix;

    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: {flake = v;}) flakeInputs;

    # set the path for channels compat
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    settings = {
      cores = 6;
      max-jobs = 1;
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "/etc/nix/registry.json";
      keep-derivations = true;
      keep-outputs = true;
      trusted-users = ["root" "@wheel"];
    };
  };
}
