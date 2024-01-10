{
  inputs,
  withSystem,
  module_args,
  ...
}: let
  sharedModules = [
    ../.

    module_args
    inputs.ags.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    inputs.nix-index-db.hmModules.nix-index
  ];

  homeImports = {
    "gorgeos" = [./gorgeos] ++ sharedModules;
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
    });
  };
}
