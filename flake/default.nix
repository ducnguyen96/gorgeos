{
  imports = [
    ./pre-commit-hooks.nix
    ./modules

    ../home
    ../hosts
    ../lib
    ../pkgs
  ];

  systems = ["x86_64-linux"];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      DIRENV_LOG_FORMAT = "";

      packages = with pkgs; [
        alejandra
        deadnix
        git
        nil
      ];

      shellHook = ''
        ${config.pre-commit.installationScript}
      '';
    };

    formatter = pkgs.alejandra;
  };
}
