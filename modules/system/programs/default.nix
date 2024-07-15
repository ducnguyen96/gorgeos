{
  imports = [
    ./bash.nix
    ./home-manager.nix
    ./zsh.nix
    ./steam.nix
  ];

  programs = {
    dconf.enable = true;
  };
}
