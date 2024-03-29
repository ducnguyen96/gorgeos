{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./scripts

    ./starship.nix
    ./zsh.nix
    ../programs/git.nix
  ];

  home = {
    packages = with pkgs; [
      htop
    ];

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      NIX_AUTO_RUN = "1";
    };
  };

  programs = {
    eza.enable = true;
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

    thefuck = {
      enable = true;
      enableZshIntegration = true;
    };

    ssh = {
      enable = true;

      extraConfig = ''
        Host e14g2
        User duc
        Hostname 192.168.1.17
        Port 22
        IdentityFile ~/.ssh/id_ed25519
      '';
    };
  };

  services = {
  };
}
