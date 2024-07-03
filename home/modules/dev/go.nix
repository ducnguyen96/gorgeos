{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      go
    ];

    sessionVariables = rec {
      GOPATH = "${config.xdg.dataHome}/go";
      GOBIN = "${GOPATH}/bin";
    };
  };
}
