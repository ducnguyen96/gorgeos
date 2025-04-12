{
  config,
  pkgs,
  ...
}: let
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "SUPER, ${ws}, workspace, ${toString (x + 1)}"
        "SUPER_SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
        "ALT_SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
      ]
    )
    10);

  runOnce = program: "pgrep ${program} || ${program}";

  terminal = config.home.sessionVariables.TERMINAL;
  defaultApp = type: "${pkgs.gtk3}/bin/gtk-launch $(${pkgs.xdg-utils}/bin/xdg-mime query default ${type})";
  browser = defaultApp "x-scheme-handler/https";
  editor = defaultApp "text/plain";
in {
  wayland.windowManager.hyprland = {
    settings = {
      bind =
        [
          # compositor commands
          "SUPERSHIFT, E, exec, pkill Hyprland"
          "SUPER, Q, killactive"
          "SUPER, S, togglesplit"
          "SUPER, F, fullscreen"
          "SUPER, P, pseudo"
          "SUPERSHIFT, P, pin"
          "SUPER, Space, exec, hyprctl dispatch togglefloating && hyprctl dispatch resizeactive exact 50% 94% && hyprctl dispatch movewindowpixel exact 25% 5%, activewindow"
          "SUPERALT, ,resizeactive,"

          # grouped (tabbed) windows
          "SUPER, G, togglegroup"
          "SUPER, TAB, changegroupactive, f"
          "SUPERSHIFT, TAB, changegroupactive, b"

          # cycle through windows
          "SUPERALT, Tab, cyclenext"
          "SUPERALT, Tab, bringactivetotop"
          "ALTSHIFT, Tab, cyclenext, prev"
          "ALTSHIFT, Tab, bringactivetotop"
          "SUPER, tab, exec, hyprctl dispatch focuscurrentorlast"

          # move focus
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"
          "SUPER, H, movefocus, l"
          "SUPER, L, movefocus, r"
          "SUPER, K, movefocus, u"
          "SUPER, J, movefocus, d"

          # move windows
          "SUPERSHIFT, left, movewindow, l"
          "SUPERSHIFT, right, movewindow, r"
          "SUPERSHIFT, up, movewindow, u"
          "SUPERSHIFT, down, movewindow, d"
          "SUPERSHIFT, H, movewindow, l"
          "SUPERSHIFT, L, movewindow, r"
          "SUPERSHIFT, K, movewindow, u"
          "SUPERSHIFT, J, movewindow, d"

          # Resize windows
          "SUPER_CTRL, left, resizeactive, -20 0"
          "SUPER_CTRL, H, resizeactive, -20 0"
          "SUPER_CTRL, right, resizeactive,  20 0"
          "SUPER_CTRL, L, resizeactive,  20 0"
          "SUPER_CTRL, up, resizeactive,  0 -20"
          "SUPER_CTRL, K, resizeactive,  0 -20"
          "SUPER_CTRL, down, resizeactive,  0 20"
          "SUPER_CTRL, J, resizeactive,  0 20"

          # special workspaces
          "SUPERSHIFT, grave, movetoworkspace, special"
          "SUPER, grave, togglespecialworkspace, eDP-1"

          # cycle workspaces
          "SUPER, bracketleft, workspace, m-1"
          "SUPER, bracketright, workspace, m+1"

          # cycle monitors
          "SUPERSHIFT, bracketleft, focusmonitor, l"
          "SUPERSHIFT, bracketright, focusmonitor, r"

          # send focused workspace to left/right monitors
          "SUPERSHIFT ALT, bracketleft, movecurrentworkspacetomonitor, l"
          "SUPERSHIFT ALT, bracketright, movecurrentworkspacetomonitor, r"

          # utilities
          "SUPER, Return, exec, ${terminal} -e nvim +terminal --listen /tmp/nvim-server.pipe"
          "SUPER, B, exec, ${browser}"
          "SUPER, C, exec, hyprctl dispatch togglefloating && hyprctl dispatch resizeactive exact 50% 94% && hyprctl dispatch movewindowpixel exact 25% 5%, activewindow"
          "SUPER, E, exec, ${editor}"
          "SUPER, R, exec, ${terminal} -e ranger"
          "SUPER, N, exec, ${terminal} -e nvim --listen /tmp/nvim-server.pipe"
          "SUPER, ESCAPE, exec, wofi-power"
          "SUPER, F4, exec, ${terminal} -e pulsemixer"
          "SUPER, O, exec, ${runOnce "wl-ocr"}"
          "SUPERSHIFT ALT, L, exec, pgrep hyprlock || hyprlock"
          "SUPER, Z, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw"
          "SUPERSHIFT, Z, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw"

          # screenshot
          ", Print, exec, ${runOnce "grimblast"} --notify copysave area"
          ", F10, exec, ${runOnce "grimblast"} --notify copysave area"
          "CTRL, Print, exec, ${runOnce "grimblast"} --notify --cursor copysave output"
          "ALT, Print, exec, ${runOnce "grimblast"} --notify --cursor copysave screen"
        ]
        ++ workspaces;

      bindr = [
        # launcher
        "SUPER, D, exec, pkill wofi  || wofi -S drun"
      ];

      bindle = [
        # audio
        ",XF86AudioRaiseVolume, exec, volumectl up 5"
        ",XF86AudioLowerVolume, exec, volumectl down 5"
        ",XF86AudioMute, exec, volumectl toggle-mute"
        ",XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute"
        ", F11, exec, volumectl down 5"
        ", F12, exec, volumectl up 5"

        # brightness
        ",F8, exec, vcpctl up 5"
        ",F7, exec, vcpctl down 5"

        ",XF86MonBrightnessUp, exec, lightctl up 5"
        ",XF86MonBrightnessDown, exec, lightctl down 5"
      ];

      # mouse bindings
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
        "SUPER ALT, mouse:272, resizewindow"
      ];
    };
  };
}
