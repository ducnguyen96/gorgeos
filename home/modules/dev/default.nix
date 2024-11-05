{pkgs, ...}: {
  imports = [
    ./aws.nix
    ./kubernetes.nix
    ./nix.nix
    ./rust.nix
    ./typescript.nix
  ];

  home.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  };
}
