{
  inputs,
  withSystem,
  module_args,
  ...
}: let
  sharedModules = [
    ../.
    ../shell

    module_args
    inputs.ags.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    inputs.nix-index-db.hmModules.nix-index
  ];

  homeImports = {
    "gorgeos" = [./gorgeos] ++ sharedModules;
    "wsl" = [./wsl] ++ [../. ../shell/minimal.nix];
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
  imports = [
    {_module.args = {inherit homeImports;};}
  ];

  flake = {
    homeConfigurations = withSystem "x86_64-linux" ({pkgs, ...}: {
      "gorgeos" = homeManagerConfiguration {
        modules = homeImports."gorgeos";
        inherit pkgs;
      };

      "wsl" = homeManagerConfiguration {
        modules = homeImports."wsl";
        inherit pkgs;
      };
    });
  };
}
