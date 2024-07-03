{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      go
      gofumpt
      golangci-lint
      gomodifytags
      gopls
      impl
      delve
      gotools # goimports
    ];

    sessionVariables = rec {
      GOPATH = "${config.xdg.dataHome}/go";
      GOBIN = "${GOPATH}/bin";
    };
  };
}
