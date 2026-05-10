{
  inputs,
  self,
  ...
}: let
  sharedModules = [
    ../modules/dev

    ../modules/programs/kitty.nix
    ../modules/programs/neovim
    ../modules/programs/firefox.nix

    ../modules/shell/programs
    ../modules/shell/services/ssh.nix
    ../modules/shell/utils.nix
  ];

  desktopModules =
    [
      ./desktop/configuration.nix

      ../modules/gtk.nix
      ../modules/themes

      ../modules/shell
      ../modules/programs/fcitx5.nix
      ../modules/programs/rofi
      ../modules/programs/media

      ../modules/wayland/wayland.nix
      ../modules/wayland/windowManager/hyprland
    ]
    ++ sharedModules;

  macModules = [./mac/configuration.nix] ++ sharedModules;

  droidModules = [
    ./droid/configuration.nix

    ../modules/dev

    ../modules/programs/neovim
    ../modules/shell/programs
    ../modules/shell/services/ssh.nix
  ];

  mkHome = {
    hostname,
    modules,
    systemConfigurations,
  }: let
    inherit (systemConfigurations.${hostname}) pkgs config;
  in
    inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = {
        inherit inputs self;
        osConfig = config;
      };
      inherit pkgs modules;
    };

  mkDesktop = hostname:
    mkHome {
      inherit hostname;
      modules = desktopModules;
      systemConfigurations = self.nixosConfigurations;
    };

  mkMac = hostname:
    mkHome {
      inherit hostname;
      modules = macModules;
      systemConfigurations = self.darwinConfigurations;
    };

  mkDroid = hostname:
    mkHome {
      inherit hostname;
      modules = droidModules;
      systemConfigurations = self.nixOnDroidConfigurations;
    };
in {
  mac = mkMac "silicon";

  "desktop@e14g2" = mkDesktop "e14g2";
  "desktop@5560" = mkDesktop "5560";
  "desktop@rtx2070" = mkDesktop "rtx2070";
  "desktop@utm" = mkDesktop "utm";

  droid = mkDroid "droid";
}
