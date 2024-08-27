{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      jdk
      android-studio
      nodePackages.eas-cli
    ];
  };
}
