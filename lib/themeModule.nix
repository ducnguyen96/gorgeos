{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.custom.theme;

  # Get the available themes from your theme directory
  themesPath = ./themes;
  availableThemes = builtins.attrNames (builtins.readDir themesPath);
in {
  options.custom.theme = {
    name = mkOption {
      type = types.enum availableThemes;
      default = "catppuccin";
      description = "Theme to use for the system";
    };

    # Optional: Add more granular options if needed
    variant = mkOption {
      type = types.enum ["frappe" "latte" "macchiato" "mocha"];
      default = "mocha";
      description = "Specific variant of the theme to use";
    };
  };

  config = {
    # Create symlinks for theme files in ~/.config/theme
    home.file = let
      themePath = "${themesPath}/${cfg.name}";
      themeFiles = builtins.attrNames (builtins.readDir themePath);
    in
      builtins.listToAttrs (map (file: {
          name = ".config/theme/${file}";
          value = {source = "${themePath}/${file}";};
        })
        themeFiles);

    # Store theme information in environment variables
    home.sessionVariables = {
      CURRENT_THEME = cfg.name;
      CURRENT_THEME_VARIANT = cfg.variant;
    };
  };
}
