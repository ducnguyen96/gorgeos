{
  outputs = inputs @ {
    flake-parts,
    pre-commit-hooks,
    ...
  }:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./home
        ./hosts
        pre-commit-hooks.flakeModule
      ];

      systems = ["x86_64-linux"];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        pre-commit = {
          check.enable = true;

          settings.excludes = ["flake.lock"];

          settings.hooks = {
            alejandra.enable = true;
            commitizen.enable = true;
            nil.enable = true;
          };
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            deadnix
            git
            nil
          ];

          DIRENV_LOG_FORMAT = "";
          shellHook = ''
            ${config.pre-commit.installationScript}
          '';
        };

        formatter = pkgs.alejandra;
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:ducnguyen96/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
