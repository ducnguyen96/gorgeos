{pkgs, ...}: {
  imports = [
    ../modules/theme

    ../modules/programs/media
    ../modules/programs/neovim
    ../modules/programs/fcitx5.nix
    ../modules/programs/firefox.nix
    ../modules/programs/kitty.nix

    ../modules/dev/default.nix

    ../modules/shell

    ../modules/wayland/wayland.nix
    ../modules/wayland/windowManager/hyprland
    ../modules/x11/i3
  ];

  dev = {
    angular = {
      enable = false;
      useMasonLSP = true;
      asHomePkgs = false;
    };
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
      enable = false;
      useMasonLSP = false;
      asHomePkgs = false;
    };
    nix = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    python = {
      enable = false;
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
    tex = {
      enable = false;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    tailwind.enable = true;
  };

  custom.theme = {
    name = "catppuccin";
    variant = "mocha";
  };

  home = {
    username = "duc";
    homeDirectory = "/home/duc";
    sessionVariables = {
      XDG_SCREENSHOTS_DIR = "/home/duc/Screenshots";
      LD_LIBRARY_PATH = "${pkgs.gcc15.cc.lib}/lib:/run/opengl-driver/lib:LD_LIBRARY_PATH";
    };

    packages = with pkgs; [
      go-task
      # shotcut # video editor
      remmina # Remote desktop client written in GTK
      # telegram-desktop
      # google-chrome # browser
      # gimp # image editor
      xfce.thunar
      # audacity
      # chromium
      dbeaver-bin # Sql client
      android-tools
      scrcpy
      cloudflare-warp
      slack
      heroku
      postman
      code-cursor
      zip
      wineWowPackages.stable
      doxx
      cloudflared
    ];
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;
}
