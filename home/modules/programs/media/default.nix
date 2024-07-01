{pkgs, ...}: {
  imports = [
    ./mpv.nix
    ./obs-studio.nix
    ./rnnoise.nix
  ];

  home.packages = with pkgs; [
    celluloid
    imv
    loupe
    pavucontrol
    playerctl
    pulsemixer
  ];

  xdg.mimeApps.defaultApplications = {
    "audio/*" = "io.bassi.Amberol";
    "image/*" = "org.gnome.Loupe";
    "video/*" = "io.github.celluloid_player.Celluloid";
  };
}
