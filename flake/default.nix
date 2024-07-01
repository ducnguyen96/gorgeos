{
  imports = [
    ./pre-commit-hooks.nix
    ./modules

    ../home
    ../hosts
    ../lib
  ];

  systems = ["x86_64-linux"];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
      ];

      DIRENV_LOG_FORMAT = "";
      shellHook = ''
        ${config.pre-commit.installationScript}
      '';
    };
  };
}
