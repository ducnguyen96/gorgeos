{pkgs, ...}: {
  home.packages = with pkgs; [
    curl
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
    aider-chat
  ];
}
