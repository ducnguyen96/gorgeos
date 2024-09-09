{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./home-manager.nix
    ./zsh.nix
  ];

  programs = {
    dconf.enable = true;
    nix-ld.enable = true;
    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };
}
