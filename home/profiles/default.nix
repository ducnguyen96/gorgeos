{
  inputs,
  withSystem,
  module_args,
  ...
}: let
  sharedModules = [
    ../.

    module_args
  ];

  homeImports = {
    "main" = [./main] ++ sharedModules;
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
  imports = [
    {_module.args = {inherit homeImports;};}
  ];

  flake = {
    homeConfigurations = withSystem "x86_64-linux" ({pkgs, ...}: {
      "main" = homeManagerConfiguration {
        modules = homeImports."main";
        inherit pkgs;
      };
    });
  };
}
