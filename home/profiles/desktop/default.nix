{
  inputs,
  self,
  ...
}: let
  modules = [
    ./configuration.nix
    ../../modules/gtk.nix

    ../../modules/themes

    ../../modules/programs/media
    ../../modules/programs/kitty.nix
    ../../modules/dev
    ../../modules/programs/neovim
    ../../modules/programs/fcitx5.nix
    ../../modules/programs/firefox.nix
    ../../modules/programs/rofi

    ../../modules/services/ollama.nix

    ../../modules/shell

    ../../modules/wayland/wayland.nix
    ../../modules/wayland/windowManager/hyprland
  ];
in {
  flake.homeConfigurations = {
    "desktop@e14g2" = let
      inherit (self.nixosConfigurations.e14g2) pkgs config;
    in
      inputs.home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inherit inputs self;
          osConfig = config;
        };

        inherit pkgs modules;
      };

    "desktop@rtx2070" = let
      inherit (self.nixosConfigurations.rtx2070) pkgs config;
    in
      inputs.home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inherit inputs self;
          osConfig = config;
        };

        inherit pkgs modules;
      };
  };
}
