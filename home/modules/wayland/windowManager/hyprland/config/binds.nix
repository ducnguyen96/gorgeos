{
  config,
  pkgs,
  ...
}: let
  # Screenshot utility
  screenshotarea = "hyprctl keyword animation 'fadeOut,0,0,default'; grimblast --notify copysave area; hyprctl keyword animation 'fadeOut,1,4,default'";

  # Binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "SUPER, ${ws}, workspace, ${toString (x + 1)}"
        "SUPERSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);

  # Get default application
  gtk-launch = "${pkgs.gtk3}/bin/gtk-launch";
  xdg-mime = "${pkgs.xdg-utils}/bin/xdg-mime";
  defaultApp = type: "${gtk-launch} $(${xdg-mime} query default ${type})";
  terminal = config.home.sessionVariables.TERMINAL;
  browser = defaultApp "x-scheme-handler/https";
  editor = defaultApp "text/plain";
in {
  wayland.windowManager.hyprland = {
    settings = {
      bind = let
        monocle = "dwindle:no_gaps_when_only";
      in
        [
          # Compositor commands
          "SUPERSHIFT, Q, exit"
          "SUPER, Q, killactive"
          "SUPER, S, togglesplit"
          "SUPER, F, fullscreen"
          "SUPER, P, pseudo"
          "SUPERSHIFT, P, pin"
          "SUPER, Space, togglefloating"

          # Toggle "monocle" (no_gaps_when_only)
          "SUPER, M, exec, hyprctl keyword ${monocle} $(($(hyprctl getoption ${monocle} -j | jaq -r '.int') ^ 1))"

          # Grouped (tabbed) windows
          "SUPER, G, togglegroup"
          "SUPER, TAB, changegroupactive, f"
          "SUPERSHIFT, TAB, changegroupactive, b"

          # Cycle through windows
          "ALT, Tab, cyclenext"
          "ALT, Tab, bringactivetotop"
          "ALTSHIFT, Tab, cyclenext, prev"
          "ALTSHIFT, Tab, bringactivetotop"
          "SUPER, tab, exec, hyprctl dispatch focuscurrentorlast"

          # Move focus
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"

          "$SUPER, H, movefocus, l"
          "$SUPER, L, movefocus, r"
          "$SUPER, J, movefocus, u"
          "$SUPER, K, movefocus, d"
          "ALT, Tab, movefocus, d"

          "SUPER, bracketleft, workspace, m-1"
          "SUPER, bracketright, workspace, m+1"

          # Move windows
          "SUPERSHIFT, left, movewindow, l"
          "SUPERSHIFT, right, movewindow, r"
          "SUPERSHIFT, up, movewindow, u"
          "SUPERSHIFT, down, movewindow, d"

          # Special workspaces
          "SUPERSHIFT, grave, movetoworkspace, special"
          "SUPER, grave, togglespecialworkspace, eDP-1"

          # Cycle through workspaces
          "SUPERALT, up, workspace, m-1"
          "SUPERALT, down, workspace, m+1"

          # Utilities
          "SUPER, Return, exec, run-as-service ${terminal}"
          "SUPER, B, exec, ${browser}"
          "SUPER, E, exec, ${editor}"
          "SUPER, R, exec, ${terminal} -e ranger"
          "SUPER, M, exec, ${terminal} -e ncmpcpp"
          "SUPER, N, exec, ${terminal} -e nvim --listen /tmp/nvim-server.pipe"
          "SUPER, L, exec, ${pkgs.systemd}/bin/loginctl lock-session"
          "SUPER, ESCAPE, exec, wofi-power"
          "SUPER, O, exec, run-as-service wl-ocr"

          # Screenshot
          ", Print, exec, ${screenshotarea}"
          ", F10, exec, ${screenshotarea}"
          ", Print, exec, ${screenshotarea}"
          "CTRL, Print, exec, grimblast --notify --cursor copysave output"
          "ALT, Print, exec, grimblast --notify --cursor copysave screen"
        ]
        ++ workspaces;

      bindr = [
        # Launchers
        "SUPER, D, exec, pkill wofi  || wofi -S drun"
      ];

      binde = [
        ",XF86AudioRaiseVolume, exec, volumectl up .05"
        ",XF86AudioLowerVolume, exec, volumectl down .05"

        ", F3, exec, volumectl down .05"
        ", F4, exec, volumectl up .05"
        "SUPER, F4, exec, ${terminal} -e pulsemixer"

        ",XF86AudioMute, exec, volumectl toggle-mute"

        ",XF86MonBrightnessUp, exec, lightctl up 5"
        ",XF86MonBrightnessDown, exec, lightctl down 5"

        ", F5, exec, lightctl down 5"
        ", F6, exec, lightctl up 5"
      ];

      # Mouse bindings
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };

    # Configure submaps
    extraConfig = ''
      bind = SUPERSHIFT, S, submap, resize

      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset
    '';
  };
}
