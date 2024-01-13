{
  imports = [
    ./pre-commit-hooks.nix

    ../home/profiles
    ../hosts
    ../lib
    ../modules
    ../pkgs
  ];

  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      shellHook = ''
        ${config.pre-commit.installationScript}
      '';

      DIRENV_LOG_FORMAT = "";

      packages = with pkgs; [
        git
      ];
    };
  };
}
