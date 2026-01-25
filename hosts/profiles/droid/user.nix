{pkgs, ...}: {
  user = {
    userName = "duc";
    shell = "${pkgs.zsh}/bin/zsh";
  };
}
