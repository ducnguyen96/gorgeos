{pkgs, ...}: {
  home.packages = with pkgs; [
    pulsemixer
  ];

  programs = {
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
