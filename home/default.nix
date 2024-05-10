{
  inputs,
  lib,
  ...
}: let
  sharedModules = [
    ./modules/programs/git.nix
    ./modules/programs/ssh.nix
    ./modules/programs/starship.nix
    ./modules/programs/utils.nix
    ./modules/programs/zsh.nix
    ./modules/services/gnome-keyring.nix
  ];

  homeImports = {
    "duc@hyprland" =
      [
        ./home.nix
        ./profiles/hyprland.nix
      ]
      ++ lib.concatLists [sharedModules];
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "duc@hyprland" = homeManagerConfiguration {
        inherit pkgs;
        modules = homeImports."duc@hyprland";
      };
    };
  };
}
