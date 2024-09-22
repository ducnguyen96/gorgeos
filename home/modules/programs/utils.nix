{pkgs, ...}: {
  programs = {
    bat.enable = true;
    eza.enable = true;
    man.enable = true;
    htop.enable = true;
    btop.enable = true;

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.packages = with pkgs; [
    jq
    unzip
    cloudflare-warp
    neofetch
    libnotify
    pciutils
    unrar
    shotcut # video editor
    remmina # Remote desktop client written in GTK
    telegram-desktop
    google-chrome # browser
    gimp
    xfce.thunar
    virt-viewer
    android-tools
    openssl
    audacity
    chromium
  ];

  # Create the desktop entry in the appropriate directory
  home.file.".local/share/applications/google-chrome-wayland.desktop".text = ''
    [Desktop Entry]
    Name=Google Chrome (Wayland)
    Exec=${pkgs.google-chrome}/bin/google-chrome-stable --ozone-platform-hint=auto --enable-wayland-ime --wayland-text-input-version=3 %U
    Icon=google-chrome
    Terminal=false
    Type=Application
    Categories=Network;WebBrowser;
  '';
}
