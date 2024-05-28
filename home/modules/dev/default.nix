{pkgs, ...}: {
  imports = [
    ./cli.nix
    ./go.nix
    # ./python.nix
  ];

  home.packages = with pkgs; [
    dbeaver-bin
    nodePackages.yarn
  ];
}
