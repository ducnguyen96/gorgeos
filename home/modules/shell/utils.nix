{pkgs, ...}: {
  home.packages = with pkgs; [
    bc
    curl
    numbat
    wget
    jq
    zip
    unzip
    unrar
    fastfetch
    bemoji
    libnotify
    # pass-wayland
    # gnupg
    # gpg-tui
    # ncurses
    # pinentry-curses
  ];
}
