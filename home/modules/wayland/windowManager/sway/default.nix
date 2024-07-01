{
  pkgs,
  config,
  osConfig,
  ...
}: let
  monitor_left = osConfig.environment.variables."MONITOR_LEFT";
  monitor_right = osConfig.environment.variables."MONITOR_RIGHT";

  monitor_left_name = builtins.elemAt (builtins.split "," monitor_left) 0;
  monitor_right_name = builtins.elemAt (builtins.split "," monitor_right) 0;

  workspace_config = ''
    workspace 1 output ${monitor_left_name}
    workspace 3 output ${monitor_left_name}
    workspace 5 output ${monitor_left_name}
    workspace 7 output ${monitor_left_name}
    workspace 9 output ${monitor_left_name}

    workspace 2 output ${monitor_right_name}
    workspace 4 output ${monitor_right_name}
    workspace 6 output ${monitor_right_name}
    workspace 8 output ${monitor_right_name}
    workspace 0 output ${monitor_right_name}

    output ${monitor_left_name} resolution 1920x1080 position 0,0
    output ${monitor_right_name} resolution 1920x1080 position 1920,0
  '';

  cfg = rec {
    modifier = "Mod4";
    terminal = "kitty";

    input = {
      "*" = {
        xkb_options = "caps:escape";
        xkb_layout = "us";
      };
    };

    output."*".bg = "${config.home.homeDirectory}/.config/wallpaper.jpg fill";

    gaps = {
      inner = 10;
    };

    window = {
      titlebar = false;
    };
  };
in {
  imports = [
    ../../../scripts/volumectl.nix
  ];

  home.packages = with pkgs; [
    slurp
    grim
    wl-clipboard
  ];

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    config = cfg;

    extraConfig = ''
      ${workspace_config}

      ### Key bindings
      #
      # Basics:
      #
        # Kill focused window
        bindsym ${cfg.modifier}+q kill

      #
      # Apps:
      #
        unbindsym ${cfg.modifier}+v
        bindsym ${cfg.modifier}+v exec kitty -e nvim

        unbindsym ${cfg.modifier}+r
        bindsym ${cfg.modifier}+r exec kitty -e ranger

      #
      # More:
      #
        bindsym F10 exec grim -g "$(slurp -d)" - | wl-copy -t image/png
        bindsym F3 exec volumectl down 5
        bindsym F4 exec volumectl up 5
    '';
  };
}
