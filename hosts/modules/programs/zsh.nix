{
  lib,
  pkgs,
  ...
}: {
  environment.pathsToLink = ["/share/zsh"];

  programs = {
    less.enable = true;

    zsh = {
      enable = true;
      enableGlobalCompInit = false;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      promptInit = ''
        eval "$(${lib.getExe pkgs.starship} init zsh)"
      '';
    };
  };
}
