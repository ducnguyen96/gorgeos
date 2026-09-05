{
  config,
  lib,
  osConfig,
  ...
}: let
  monitor_one = osConfig.environment.variables."MONITOR_ONE";
  monitor_two = osConfig.environment.variables."MONITOR_TWO";

  # MONITOR_ONE/TWO are classic "output, mode, position, scale" strings.
  parseMonitor = str: let
    parts = map lib.strings.trim (lib.splitString "," str);
  in {
    output = builtins.elemAt parts 0;
    mode = builtins.elemAt parts 1;
    position = builtins.elemAt parts 2;
    scale = builtins.elemAt parts 3;
  };

  monitor_one_cfg = parseMonitor monitor_one;
  monitor_two_cfg = parseMonitor monitor_two;

  mkWorkspaceRule = id: monitor: {
    workspace = id;
    inherit monitor;
  };

  workspace_rule =
    map (id: mkWorkspaceRule id monitor_one_cfg.output) ["1" "3" "5" "7" "9"]
    ++ map (id: mkWorkspaceRule id monitor_two_cfg.output) ["2" "4" "6" "8" "0"];
in {
  wayland.windowManager.hyprland.configType = "lua";
  wayland.windowManager.hyprland.settings = {
    env = [
      {_args = ["GDK_SCALE" "1"];}
      {_args = ["XDG_SCREENSHOTS_DIR" "${config.home.homeDirectory}/Pictures/Screenshots"];}
    ];

    config = {
      general = {
        gaps_in = 4;
        gaps_out = 8;

        border_size = 1;
        col = {
          active_border = "rgb(AC87C5)";
          inactive_border = "rgba(00000088)";
        };

        resize_on_border = true;
        allow_tearing = true;

        layout = "dwindle";
      };

      dwindle.preserve_split = true;

      master.new_status = "master";

      decoration = {
        rounding = 16;

        active_opacity = 0.85;
        inactive_opacity = 0.5;
        fullscreen_opacity = 1.0;

        blur.enabled = true;
      };

      animations.enabled = true;

      input = {
        kb_layout = "us";
        kb_options = "caps:escape";

        follow_mouse = 1;
        sensitivity = 0.7;
        accel_profile = "flat";

        touchpad = {
          disable_while_typing = true;
          scroll_factor = 0.5;
        };
      };

      group.groupbar = {
        font_size = 16;
        gradients = false;
      };

      misc = {
        focus_on_activate = true;
        disable_autoreload = true;
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        vrr = 1;
      };

      cursor.no_hardware_cursors = true;
      debug.disable_logs = false;
      # render.direct_scanout = true;
      xwayland.force_zero_scaling = true;
    };

    # curve is rendered before animation (importantPrefixes) so the bezier
    # referenced below is already registered.
    curve = [
      {
        _args = [
          "quart"
          {
            type = "bezier";
            points = [
              [0.25 1]
              [0.5 1]
            ];
          }
        ];
      }
    ];

    animation = [
      {
        leaf = "windows";
        enabled = true;
        speed = 5;
        bezier = "quart";
        style = "popin 75%";
      }
      {
        leaf = "windowsIn";
        enabled = true;
        speed = 5;
        bezier = "quart";
        style = "popin 75%";
      }
      {
        leaf = "windowsOut";
        enabled = true;
        speed = 5;
        bezier = "quart";
        style = "popin 75%";
      }
      {
        leaf = "windowsMove";
        enabled = true;
        speed = 5;
        bezier = "default";
      }
      {
        leaf = "border";
        enabled = true;
        speed = 10;
        bezier = "default";
      }
      {
        leaf = "fade";
        enabled = true;
        speed = 5;
        bezier = "quart";
      }
      {
        leaf = "workspaces";
        enabled = true;
        speed = 5;
        bezier = "quart";
        style = "slide";
      }
      {
        leaf = "specialWorkspace";
        enabled = true;
        speed = 5;
        bezier = "quart";
        style = "slidevert";
      }
    ];

    # Custom gestures
    gesture = [
      {
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      } # Swipe horizontally with 3 fingers to switch workspaces
      {
        fingers = 3;
        direction = "down";
        mods = "SUPER";
        action = "close";
      } # Swipe down with 3 fingers + SUPER to close the active window
      {
        fingers = 3;
        direction = "up";
        mods = "SUPER";
        scale = 1.5;
        action = "fullscreen";
      } # Swipe up with 3 fingers + SUPER to toggle fullscreen
      {
        fingers = 4;
        direction = "up";
        action = "move";
      } # Swipe up with 4 fingers to move the active window up
      {
        fingers = 4;
        direction = "down";
        action = "move";
      } # Swipe down with 4 fingers to move the active window down
      {
        fingers = 4;
        direction = "left";
        action = "move";
      } # Swipe left with 4 fingers to move the active window left
      {
        fingers = 4;
        direction = "right";
        action = "move";
      } # Swipe right with 4 fingers to move the active window right
    ];

    inherit workspace_rule;

    monitor = [monitor_one_cfg monitor_two_cfg];
  };
}
