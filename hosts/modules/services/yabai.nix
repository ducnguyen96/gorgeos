{
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = {
      # ── Layout ──────────────────────────────────────────────────────────────
      layout = "bsp"; # dwindle ≈ bsp

      # ── Gaps & padding ───────────────────────────────────────────────────────
      window_gap = 4;
      top_padding = 8;
      bottom_padding = 8;
      left_padding = 8;
      right_padding = 8;

      # ── Borders ──────────────────────────────────────────────────────────────
      window_border = "on";
      window_border_width = 1;
      window_border_radius = 16;
      active_window_border_color = "0xffac87c5"; # purple, like Hyprland active
      normal_window_border_color = "0x88000000";

      # ── Opacity ───────────────────────────────────────────────────────────────
      window_opacity = "on";
      active_window_opacity = 0.95;
      normal_window_opacity = 0.7;

      # ── Mouse ─────────────────────────────────────────────────────────────────
      # follow_mouse = 1  →  autofocus (focus on hover, don't raise)
      focus_follows_mouse = "autofocus";
      mouse_follows_focus = "off";
      # SUPER+LMB drag = move, SUPER+RMB drag = resize  (set in skhd via bindm)
      mouse_modifier = "cmd";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap"; # drop onto another window → swap

      # ── Animations ────────────────────────────────────────────────────────────
      window_animation_duration = 0.2;
      window_animation_easing = "ease_out_quint"; # smooth feel like Hyprland
    };

    extraConfig = ''
      # Editors
      yabai -m rule --add app="kitty" space=1
      yabai -m rule --add app="Cursor" space=1
      yabai -m rule --add app="Terminal" space=1

      # Web
      yabai -m rule --add app="Firefox" space=2

      # Dev tools
      yabai -m rule --add app="Dbeaver" space=3
      yabai -m rule --add app="lazysql" space=3
      yabai -m rule --add app="Bruno" space=3

      # Others
      yabai -m rule --add app="Zalo" space=4

      # ── Unmanaged apps ────────────────────────────────────────────────────────
      yabai -m rule --add app="^System Settings$"    manage=off
      yabai -m rule --add app="^System Preferences$" manage=off
      yabai -m rule --add app="^Calculator$"         manage=off
      yabai -m rule --add app="^Archive Utility$"    manage=off
      yabai -m rule --add app="^Activity Monitor$"   manage=off
      yabai -m rule --add app="^Finder$"             manage=off sticky=on layer=above
      yabai -m rule --add app="^Alfred$"             manage=off
      yabai -m rule --add app="^Raycast$"            manage=off

      # Float dialog / utility windows
      yabai -m rule --add type="dialog"  manage=off
      yabai -m rule --add type="utility" manage=off
      yabai -m rule --add type="splash"  manage=off

      # ── Signal: refresh borders after layout change ────────────────────────────
      yabai -m signal --add event=window_focused    action="sketchybar --trigger window_focus"
      yabai -m signal --add event=window_created    action="sketchybar --trigger windows_on_spaces"
      yabai -m signal --add event=window_destroyed  action="sketchybar --trigger windows_on_spaces"
    '';
  };
}
