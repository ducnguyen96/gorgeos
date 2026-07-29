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
      inter
      nerd-fonts.symbols-only
    ];
  };
}
