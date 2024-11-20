{
  imports = [
    ../modules/dev/default.nix
    ../modules/programs/neovim
    ../modules/programs/nix-index-db.nix

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

  home = {
    username = "duc";
    homeDirectory = "/home/duc";
    extraOutputsToInstall = [
      "doc"
      "devdoc"
    ];
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;
}
