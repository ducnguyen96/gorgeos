{
  config,
  pkgs,
  lib,
  ...
}: let
  mod = "Mod4"; # Super key
  terminal = config.home.sessionVariables.TERMINAL or "${pkgs.kitty}/bin/kitty";
in {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;

    config = {
      modifier = mod;
      terminal = terminal;

      fonts = {
        names = ["FiraCode Nerd Font" "monospace"];
        size = 10.0;
      };

      gaps = {
        inner = 4;
        outer = 8;
      };

      window = {
        border = 1;
        titlebar = false;
      };

      floating = {
        border = 1;
        titlebar = false;
        modifier = mod;
      };

      colors = {
        focused = {
          border = "#AC87C5";
          background = "#AC87C5";
          text = "#ffffff";
          indicator = "#AC87C5";
          childBorder = "#AC87C5";
        };
        unfocused = {
          border = "#333333";
          background = "#222222";
          text = "#888888";
          indicator = "#333333";
          childBorder = "#333333";
        };
      };

      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          fonts = {
            names = ["FiraCode Nerd Font" "monospace"];
            size = 10.0;
          };
          colors = {
            background = "#1a1a2e";
            statusline = "#ffffff";
            focusedWorkspace = {
              border = "#AC87C5";
              background = "#AC87C5";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              border = "#333333";
              background = "#333333";
              text = "#888888";
            };
          };
        }
      ];

      keybindings = lib.mkOptionDefault {
        # ===== Window Management =====
        "${mod}+q" = "kill";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+space" = "floating toggle";
        "${mod}+Shift+space" = "focus mode_toggle";

        # Layout
        "${mod}+s" = "layout toggle split";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+v" = "split v";
        "${mod}+b" = "split h";

        # ===== Focus (vim-style + arrows) =====
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        # ===== Move Windows =====
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # ===== Resize Windows =====
        "${mod}+Ctrl+h" = "resize shrink width 20 px";
        "${mod}+Ctrl+j" = "resize grow height 20 px";
        "${mod}+Ctrl+k" = "resize shrink height 20 px";
        "${mod}+Ctrl+l" = "resize grow width 20 px";
        "${mod}+Ctrl+Left" = "resize shrink width 20 px";
        "${mod}+Ctrl+Down" = "resize grow height 20 px";
        "${mod}+Ctrl+Up" = "resize shrink height 20 px";
        "${mod}+Ctrl+Right" = "resize grow width 20 px";

        # ===== Workspaces =====
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        # Move to workspace
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        # Cycle workspaces
        "${mod}+bracketleft" = "workspace prev";
        "${mod}+bracketright" = "workspace next";
        "${mod}+Tab" = "workspace back_and_forth";

        # ===== Applications =====
        "${mod}+Return" = "exec ${terminal}";
        "${mod}+Shift+Return" = "exec ${terminal} -e nvim -c 'terminal' -c 'startinsert'";
        "${mod}+d" = "exec --no-startup-id ${pkgs.rofi}/bin/rofi -show drun";
        "${mod}+n" = "exec ${terminal} -e nvim";
        "${mod}+r" = "exec ${terminal} -e ranger";
        "${mod}+Escape" = "exec --no-startup-id ${pkgs.rofi}/bin/rofi -show power-menu -modi power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu";

        # ===== Session =====
        "${mod}+Shift+e" = "exec i3-nagbar -t warning -m 'Exit i3?' -B 'Yes' 'i3-msg exit'";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+c" = "reload";
      };

      startup = [
        {
          command = "${pkgs.feh}/bin/feh --bg-fill ~/.config/wallpaper.png";
          notification = false;
        }
      ];
    };
  };

  # i3status config
  programs.i3status = {
    enable = true;
    general = {
      colors = true;
      color_good = "#AC87C5";
      color_degraded = "#ffa500";
      color_bad = "#ff0000";
      interval = 1;
    };
    modules = {
      "disk /" = {
        position = 1;
        settings = {format = "💾 %avail";};
      };
      "memory" = {
        position = 2;
        settings = {format = "🧠 %used";};
      };
      "cpu_usage" = {
        position = 3;
        settings = {format = "💻 %usage";};
      };
      "tztime local" = {
        position = 4;
        settings = {format = "📅 %Y-%m-%d %H:%M:%S";};
      };
    };
  };

  home.packages = with pkgs; [
    rofi
    rofi-power-menu
    feh
    i3status
    dunst
  ];
}
