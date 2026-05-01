{
  inputs,
  self,
  ...
}: let
  modules = [
    ./configuration.nix
    ../../modules/gtk.nix

    ../../modules/themes

    ../../modules/programs/kitty.nix
    ../../modules/dev
    ../../modules/programs/neovim
    ../../modules/programs/fcitx5.nix
    ../../modules/programs/firefox.nix
    ../../modules/programs/rofi

    ../../modules/shell

    ../../modules/wayland/wayland.nix
    ../../modules/wayland/windowManager/hyprland
  ];
  filteredInputs = builtins.removeAttrs inputs ["nix-on-droid" "nix-darwin"];
in {
  flake.homeConfigurations = {
    "utm" = let
      inherit (self.nixosConfigurations.utm) pkgs config;
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
