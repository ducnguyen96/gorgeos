{pkgs, ...}: {
  # Common Wayland configuration shared by all Wayland desktop environments
  # Desktop-specific variables (like XDG_CURRENT_DESKTOP) should be set
  # in the respective desktop environment modules

  home.packages = with pkgs; [
    wl-clipboard
  ];

  home.sessionVariables = {
    # Toolkit backend
    GDK_BACKEND = "wayland,x11,*";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";

    # XDG
    XDG_SESSION_TYPE = "wayland";

    # QT
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # Firefox
    MOZ_ENABLE_WAYLAND = "1";
  };
}
