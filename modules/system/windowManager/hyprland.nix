{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONEREPARENTING = "1";
    GDK_BACKEND = "wayland,x11";
    ANKI_WAYLAND = "1";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };

  nixpkgs.overlays = with inputs; [
    nixpkgs-wayland.overlay
  ];

  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
    ];

    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  security = {
    polkit.enable = true;

    pam.services = {
      swaylock.text = "auth include login";
    };
  };

  services.xserver.desktopManager.runXdgAutostartIfNone = true;
}
