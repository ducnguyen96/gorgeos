{config, ...}: let
  themeName = config.custom.theme.name;
  themeVariant = config.custom.theme.variant;

  themePath = ../../../../../../lib/themes/${themeName};
in {
  programs.wofi = {
    enable = true;
    settings = {
      width = "60%";
      height = "40%";
      prompt = "";
      allow_images = true;
      allow_markup = true;
      exec_search = true;
      hide_scroll = true;
      insensitive = true;
      location = "center";
      columns = 3;
      gtk_dark = true;
      orientation = "vertical";
      image_size = 32;
      layer = "top";
    };
  };
  home.file.".config/wofi/style.css".source = "${themePath}/wofi/${themeVariant}.css";
}
