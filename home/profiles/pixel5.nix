{pkgs, ...}: {
  imports = [
    ../modules/dev/default.nix
    ../modules/programs/neovim

    # shell module
    ../modules/shell/programs/bat.nix
    ../modules/shell/programs/dircolors.nix
    ../modules/shell/programs/direnv.nix
    ../modules/shell/programs/eza.nix
    ../modules/shell/programs/fzf.nix
    ../modules/shell/programs/git.nix
    ../modules/shell/programs/htop.nix
    ../modules/shell/programs/ranger.nix
    ../modules/shell/programs/starship.nix
    ../modules/shell/programs/zoxide.nix
    ../modules/shell/scripts/clean.nix
    ../modules/shell/scripts/rebuild.nix
    ../modules/shell/services/ssh.nix
    ../modules/shell/zsh.nix
    ../modules/shell/utils.nix
  ];

  dev = {
    nix.enable = true;
  };

  home = {
    homeDirectory = "/data/data/com.termux.nix/files/home";
  };

  home.sessionVariables = {
    TERMINAL = "xterm-256color";
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.05";
}
