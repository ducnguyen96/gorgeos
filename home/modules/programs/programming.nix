{pkgs, ...}: {
  home.packages = with pkgs; [
    nodePackages.pnpm
    pritunl-client
    dbeaver-bin
    poetry
  ];
  home.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  };
}
