{
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

  dev = {
    angular = {
      enable = false;
      useMasonLSP = true;
      asHomePkgs = false;
    };
    clangd = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    go = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    lua = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    nix = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    python = {
      enable = false;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    rust = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    typescript = {
      enable = true;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    tex = {
      enable = false;
      useMasonLSP = false;
      asHomePkgs = true;
    };
    tailwind.enable = false;
  };
}
