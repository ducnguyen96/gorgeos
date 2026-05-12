{
  outputs = inputs @ {
    flake-parts,
    pre-commit-hooks,
    self,
    ...
  }:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        pre-commit-hooks.flakeModule
      ];

      systems = ["x86_64-linux" "aarch64-darwin" "aarch64-linux"];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        pre-commit = {
          check.enable = true;

          settings.excludes = ["flake.lock" "hardware-configuration\\.nix"];

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

      flake = {
        nixosConfigurations = import ./hosts/profiles/nixos.nix {inherit inputs;};
        darwinConfigurations = import ./hosts/profiles/darwin {inherit inputs;};
        nixOnDroidConfigurations = import ./hosts/profiles/droid {inherit inputs;};
        homeConfigurations = import ./home/profiles {inherit inputs self;};
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

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
      url = "github:nixos/nixos-hardware";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
