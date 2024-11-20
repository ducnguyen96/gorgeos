{pkgs, ...}: {
  imports = [
    ./aws.nix
    ./go.nix
    ./kubernetes.nix
    ./nix.nix
    ./rust.nix
    ./sql.nix
    ./tailwind.nix
    ./terraform.nix
    ./typescript.nix
  ];

  home.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  };
}
