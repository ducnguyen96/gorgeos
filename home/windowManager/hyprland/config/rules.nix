{
  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "blur, ^(gtk-layer-shell)$"
      "blur, bar"
      "blur, launcher"
      "blur, lockscreen"
      "blur, notifications"
      "blur, wofi"
      "ignorezero, ^(gtk-layer-shell)$"
      "ignorezero, bar"
      "ignorezero, launcher"
      "ignorezero, lockscreen"
      "ignorezero, notifications"
      "ignorezero, wofi"
    ];

    windowrulev2 = [
      "float, class:^(imv)$"
      "float, class:^(wofi)$"
      "float, title:^(com.github.Aylur.ags)$"
      "float, title:^(Media viewer)$"
      "float, title:^(Picture-in-Picture)$"
      "float, title:^(Show Me The Key)$"
      "float, class:^(showmethekey)"
      "opacity 0.3 0.3, class:^(showmethekey)"
      "idleinhibit fullscreen, class:^(firefox)$"
      "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
      "idleinhibit focus, class:^(mpv)$"
      "pin, title:^(Picture-in-Picture)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
    ];
  };
}
