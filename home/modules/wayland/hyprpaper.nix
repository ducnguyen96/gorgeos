{
  themes,
  osConfig,
  ...
}: let
  monitor_left = osConfig.environment.variables."MONITOR_LEFT";
  monitor_right = osConfig.environment.variables."MONITOR_RIGHT";

  monitor_left_name = builtins.elemAt (builtins.split "," monitor_left) 0;
  monitor_right_name = builtins.elemAt (builtins.split "," monitor_right) 0;
in {
  services.hyprpaper = {
    enable = true;

    settings = {
      preload = [
        themes.wallpaper
        themes.wallpaper2
      ];

      wallpaper = [
        "${monitor_left_name}, ${themes.wallpaper}"
        "${monitor_right_name}, ${themes.wallpaper2}"
      ];
    };
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
  '';
}
