{
  inputs,
  lib,
  ...
}: let
  sharedModules = [
    ../nix
    ../lib
    ./modules/programs/git.nix
    ./modules/programs/ssh.nix
    ./modules/programs/starship.nix
    ./modules/programs/utils.nix
    ./modules/programs/zsh.nix
  ];

  homeImports = {
    "duc@manjaro" =
      [
        ./home.nix
        ./profiles/manjaro.nix
      ]
      ++ lib.concatLists [sharedModules];
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "duc@manjaro" = homeManagerConfiguration {
        inherit pkgs;
        modules = homeImports."duc@manjaro";
      };
    };
  };
}
