{pkgs, ...}: {
  home.packages = with pkgs; [
    curl
    wget
    jq
    unzip
    unrar
  ];
}
