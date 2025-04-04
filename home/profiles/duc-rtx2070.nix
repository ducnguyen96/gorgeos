{pkgs, ...}: {
  imports = [
    ../modules/config/gtk.nix
    ../modules/config/qt.nix

    ../modules/programs/media
    ../modules/programs/neovim
    ../modules/programs/chatgpt.nix
    ../modules/programs/fcitx5.nix
    ../modules/programs/firefox.nix
    ../modules/programs/kitty.nix
    ../modules/programs/nix-index-db.nix

    ../modules/dev/default.nix

    ../modules/shell

    ../modules/wayland/windowManager/hyprland
  ];

  dev = {
    clangd = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    go = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    lua = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = false;
    };
    nix = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    python = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    rust = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    typescript = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
  };

  home = {
    username = "duc";
    homeDirectory = "/home/duc";
    extraOutputsToInstall = [
      "doc"
      "devdoc"
    ];

    packages = with pkgs; [
      # shotcut # video editor
      remmina # Remote desktop client written in GTK
      # telegram-desktop
      google-chrome # browser
      # gimp # image editor
      xfce.thunar
      pritunl-client
      ventoy-full
      # audacity
      # chromium
      dbeaver-bin # Sql client
      zstd
      cachix
      linux-wifi-hotspot
      cloudflared
      postman
      ffmpeg

      # pipx # current use: pipx install open-webui
      # gollama
      # ollama-cuda
      # lmstudio
      # vscode-fhs
      # appimage-run
      # pngquant
      # imagemagick
    ];
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;
}
