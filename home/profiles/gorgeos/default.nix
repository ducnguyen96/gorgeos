{pkgs, ...}: {
  imports = [
    ../../programs/kitty.nix
    ../../programs/vscode.nix
    ../../programs/firefox.nix
    ../../programs/media.nix
    ../../programs/fcitx5.nix
    ../../themes
    ../../windowManager/hyprland
  ];

  home.packages = with pkgs; [
    pritunl-client
  ];
}
