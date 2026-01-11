{osConfig, ...}: let
  monitor_one = osConfig.environment.variables."MONITOR_ONE";
  monitor_two = osConfig.environment.variables."MONITOR_TWO";

  monitor_one_name = builtins.elemAt (builtins.split "," monitor_one) 0;
  monitor_two_name = builtins.elemAt (builtins.split "," monitor_two) 0;
in {
  services.hyprpaper = {
    enable = true;

    settings = {
      splash = false;

      preload = [
        "~/Pictures/Wallpapers/Clearnight.jpg"
        "~/Pictures/Wallpapers/tropic_island_night.jpg"
      ];

      wallpaper = [
        {
          monitor = "${monitor_one_name}";
          path = "~/Pictures/Wallpapers/tropic_island_night.jpg";
        }
        {
          monitor = "${monitor_two_name}";
          path = "~/Pictures/Wallpapers/tropic_island_night.jpg";
        }
      ];
    };
  };
}
