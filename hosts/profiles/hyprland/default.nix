{
  inputs,
  pkgs,
  ...
}: {
  environment = {
    sessionVariables = {
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland,x11";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
      NVD_BACKEND = "direct";
    };

    systemPackages = with pkgs; [
      egl-wayland
    ];
  };

  programs = {
    hyprland = {
      enable = true;

      xwayland.enable = true;
    };

    dconf.enable = true;
    xwayland.enable = true;
  };

  security = {
    pam.services.hyprlock = {
      text = "auth include login";
    };
  };

  xdg.portal = {
    enable = true;

    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
