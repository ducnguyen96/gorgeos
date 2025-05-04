{pkgs, ...}: {
  imports = [
    ../modules/dev/default.nix
    ../modules/programs/neovim

    # shell module
    ../modules/shell/programs/fzf.nix
    ../modules/shell/programs/git.nix
    ../modules/shell/programs/htop.nix
    ../modules/shell/programs/ranger.nix
    ../modules/shell/programs/starship.nix
    ../modules/shell/zsh.nix
    ../modules/shell/utils.nix
  ];

  dev = {
    clangd = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    lua = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    typescript = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  home = {
    packages = with pkgs; [
      # ncurses5
      # rsync
      # openssh
      # unixtools.ifconfig
      # leetcode-cli
    ];

    homeDirectory = "/data/data/com.termux.nix/files/home";
    sessionVariables = {
      TERMINAL = "xterm-256color";
      SHELL = "${pkgs.zsh}/bin/zsh";
    };
    stateVersion = "24.05";
  };
}
