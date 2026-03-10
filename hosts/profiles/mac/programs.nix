{
  pkgs,
  lib,
  ...
}: {
  programs.bash = {
    enable = true;
    interactiveShellInit = ''eval "$(${lib.getExe pkgs.starship} init bash)"'';
  };

  programs.zsh = {
    enable = true;

    enableGlobalCompInit = false;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    promptInit = ''
      eval "$(${lib.getExe pkgs.starship} init zsh)"
    '';
  };
}

