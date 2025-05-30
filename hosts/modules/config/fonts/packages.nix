{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;

    packages = with pkgs; [
      # System Fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji

      # Monospace
      jetbrains-mono

      # Icon Fonts
      material-design-icons

      # Custom Fonts
      (google-fonts.override {fonts = ["Inter"];})
      nerd-fonts.symbols-only
    ];
  };
}
