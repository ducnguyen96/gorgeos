{pkgs, ...}: {
  home.packages = with pkgs; [
    microsoft-edge
  ];

  # Create the desktop entry in the appropriate directory
  home.file.".local/share/applications/microsoft-edge-wayland.desktop".text = ''
    [Desktop Entry]
    Name=Microsoft Edge (Wayland)
    Exec=${pkgs.microsoft-edge}/bin/microsoft-edge-stable --ozone-platform-hint=auto --enable-wayland-ime --wayland-text-input-version=3
    Icon=microsoft-edge
    Terminal=false
    Type=Application
    Categories=Network;WebBrowser;
  '';
}
