{pkgs, ...}: {
  imports = [
    ../modules/config/gtk.nix
    ../modules/config/qt.nix

    ../modules/programs/media
    ../modules/programs/neovim
    ../modules/programs/chatgpt.nix
    ../modules/programs/fcitx5.nix
    ../modules/programs/kitty.nix
    ../modules/programs/microsoft-edge.nix
    ../modules/programs/nix-index-db.nix

    ../modules/dev/default.nix

    ../modules/shell

    ../modules/wayland/windowManager/hyprland
  ];

  dev = {
    nix.enable = true;
  };

  home = {
    username = "duc";
    homeDirectory = "/home/duc";
    extraOutputsToInstall = [
      "doc"
      "devdoc"
    ];

    packages = with pkgs; [
      pciutils
      ddcutil
      ddcui

      # shotcut # video editor
      # remmina # Remote desktop client written in GTK
      # telegram-desktop
      # google-chrome # browser
      # gimp # image editor
      xfce.thunar
      pritunl-client
      # audacity
      # chromium
      # cloudflare-warp
    ];
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;
}
