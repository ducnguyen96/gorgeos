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
    ../../modules/programs/chess.nix
    ../../modules/programs/fcitx5.nix
    ../../modules/programs/firefox.nix
    ../../modules/programs/rofi

    ../../modules/services/ollama.nix

    ../../modules/shell

    ../../modules/wayland/wayland.nix
    ../../modules/wayland/windowManager/hyprland
  ];
  filteredInputs = builtins.removeAttrs inputs ["nix-on-droid" "nix-darwin"];
in {
  flake.homeConfigurations = {
    "desktop@e14g2" = let
      inherit (self.nixosConfigurations.e14g2) pkgs config;
    in
      inputs.home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inputs = filteredInputs;
          inherit self;
          osConfig = config;
        };

        inherit pkgs modules;
      };

    "desktop@rtx2070" = let
      inherit (self.nixosConfigurations.rtx2070) pkgs config;
    in
      inputs.home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inputs = filteredInputs;
          inherit self;
          osConfig = config;
        };

        inherit pkgs modules;
      };
  };
}
