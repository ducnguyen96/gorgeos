{
  pkgs,
  config,
  ...
}: {
  programs.waybar = {
    enable = true;

    systemd = {
      enable = true;
      target = "graphical-session.target";
    };

    settings = import ./settings.nix {
      inherit pkgs config;
    };

    style = import ./style.nix;
  };
}
