{
  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} {imports = [./flake];};

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";

    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
  };
}
