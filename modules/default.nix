{
  self,
  inputs,
  default,
  ...
}: let
  module_args._module.args = {
    inherit default inputs self;
  };
in {
  _module.args = {
    inherit module_args;

    sharedModules = [
      module_args

      self.nixosModules.system
    ];
  };

  flake.nixosModules = {
    system = import ./system;
    hyprland = import ./system/windowManager/hyprland.nix;
  };
}
