{
  lib,
  inputs,
  ...
}:
with lib; let
  themesPath = ./themes;
  availableThemes = builtins.attrNames (builtins.readDir themesPath);
in {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  config.catppuccin = {
    enable = true;

    nvim.enable = false;
    kitty.enable = false;
    waybar.enable = false;
    cursors.enable = true;
  };

  options.custom.theme = {
    name = mkOption {
      type = types.enum availableThemes;
      default = "catppuccin";
      description = "Theme to use for the system";
    };

    variant = mkOption {
      type = types.enum ["frappe" "latte" "macchiato" "mocha"];
      default = "mocha";
      description = "Specific variant of the theme to use";
    };
  };
}
