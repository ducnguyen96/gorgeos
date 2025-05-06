{pkgs, ...}: {
  imports = [
    ./mpv.nix
    ./obs-studio.nix
    ./rnnoise.nix
  ];

  home.packages = with pkgs; [
    imv
    pulsemixer
  ];

  xdg.mimeApps.defaultApplications = {
    "audio/*" = "mpv.desktop";
    "image/*" = "imv.desktop";
    "video/*" = "mpv.desktop";
    "application/pdf" = ["firefox.desktop"];
  };
}
