{pkgs, ...}: {
  imports = [
    ./cli.nix
    ./go.nix
    ./python.nix
  ];

  home.packages = with pkgs; [
    pritunl-client
    dbeaver
    google-chrome
  ];
}
