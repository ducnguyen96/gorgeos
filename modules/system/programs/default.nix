{
  lib,
  pkgs,
  ...
}: {
  programs = {
    bash.promptInit = ''eval "$(${lib.getExe pkgs.starship} init bash)"'';

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      promptInit = ''
        eval "$(${lib.getExe pkgs.starship} init zsh)"
      '';
    };

    virt-manager = {
      enable = true;
    };
  };
}
