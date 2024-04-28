{pkgs, ...}: {
  imports = [
    ./cli.nix
  ];

  home.packages = with pkgs; [
    pritunl-client
    dbeaver

    nodePackages.yarn
    nodePackages.pnpm
    go
  ];
}
