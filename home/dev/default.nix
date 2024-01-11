{pkgs, ...}: {
  imports = [
    ./cli.nix
  ];

  home.packages = with pkgs; [
    pritunl-client
    authy
    dbeaver
  ];
}
