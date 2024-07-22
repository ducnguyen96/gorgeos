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
  ];
}
