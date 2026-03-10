{
  inputs,
  self,
  ...
}: let
  modules = [
    ./configuration.nix

    ../../modules/programs/kitty.nix
    ../../modules/dev
    ../../modules/programs/neovim
    ../../modules/programs/firefox.nix

    ../../modules/shell/programs
    ../../modules/shell/services/ssh.nix
    ../../modules/shell/utils.nix
  ];
in {
  flake.homeConfigurations = {
    "duc@mac" = let
      inherit (self.darwinConfigurations.mac) pkgs config;
    in
      inputs.home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inherit self;
          osConfig = config;
        };

        inherit pkgs modules;
      };
  };
}
