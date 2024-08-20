{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      watchman
      jdk
      android-studio
    ];
  };
}
