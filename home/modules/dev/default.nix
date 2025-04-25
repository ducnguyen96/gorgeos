{pkgs, ...}: {
  imports = [
    ./angular.nix
    ./aws.nix
    ./clangd.nix
    ./go.nix
    ./kubernetes.nix
    ./lua.nix
    ./nix.nix
    ./php.nix
    ./python.nix
    ./rust.nix
    ./sql.nix
    ./tailwind.nix
    ./terraform.nix
    ./tex.nix
    ./typescript.nix
    ./vue.nix
  ];

  home.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:/run/opengl-driver/lib:LD_LIBRARY_PATH";
  };
}
