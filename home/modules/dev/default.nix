{pkgs, ...}: {
  imports = [
    ./nix.nix
    ./kubernetes.nix
  ];

  home.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  };
}
