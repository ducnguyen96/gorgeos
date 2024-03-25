{pkgs, ...}: {
  imports = [
    ./cli.nix
  ];

  home.packages = with pkgs; [
    pritunl-client
    authy
    dbeaver

    nodePackages.yarn
    nodePackages.pnpm
    nodePackages.firebase-tools
    php
    go
  ];
}
