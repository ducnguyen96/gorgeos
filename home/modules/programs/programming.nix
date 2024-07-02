{pkgs, ...}: {
  home.packages = with pkgs; [
    nodePackages.pnpm
    pritunl-client
    dbeaver-bin
  ];
}
