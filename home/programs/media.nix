{pkgs, ...}: {
  home.packages = with pkgs; [
    pulsemixer
  ];

  programs = {
    mpv = {
      enable = true;
      bindings = {
        UP = "add volume +2";
        DOWN = "add volume -2";
      };
      config = {
        hwdec = "auto";
        border = false;
      };
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [wlrobs];
    };
  };

  xdg.mimeApps.defaultApplications = {
    "audio/*" = "mpv.desktop";
    "video/*" = "mpv.desktop";
    "image/*" = "imv.desktop";
  };
}
