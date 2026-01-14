{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;

    packages = with pkgs; [
      # System Fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji

      # Monospace
      jetbrains-mono

      # Custom Fonts
      (google-fonts.override {fonts = ["Inter"];})
      nerd-fonts.symbols-only
    ];
  };
}
