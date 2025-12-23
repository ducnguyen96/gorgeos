{pkgs, ...}: {
  home.packages = with pkgs; [
    bc
    curl
    numbat
    wget
    jq
    unzip
    unrar
    neofetch
    bemoji
    libnotify
    # pass-wayland
    # gnupg
    # gpg-tui
    # ncurses
    # pinentry-curses
  ];
}
