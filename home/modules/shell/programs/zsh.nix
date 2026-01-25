{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../extra-completions
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    dotDir = config.xdg.configHome + "/zsh";

    dirHashes = {
      dl = "$HOME/Downloads";
      docs = "$HOME/Documents";
      pics = "$HOME/Pictures";
      vids = "$HOME/Videos";
      mss = "$HOME/Music";
    };

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      LC_ALL = "en_US.UTF-8";
      PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = 1;
    };

    shellAliases = with lib;
    with pkgs; {
      cat = "${getExe bat} --color=always --theme=base16 --style=plain --paging=never";
      la = "${getExe eza} -lah --tree";
      ls = "${getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";
      tree = "${getExe eza} --tree --icons --tree";

      du = getExe dust;
      grep = getExe ripgrep;
      ps = getExe procs;

      cp = "cp -iv";
      rm = "rm -iv";
      mv = "mv -iv";

      nb = "nix-build";
      nd = "nix develop";
      nr = "nix run";
      ns = "nix-shell";
      nu = "nix-update";
      hm = "home-manager";

      awsume = ". awsume";
    };

    initContent = lib.mkOrder 550 ''
      eval "$(${pkgs.starship}/bin/starship init zsh)"
      fpath+=("$HOME/.config/zsh/extra-completions")

      while read -r option; do
        setopt $option
      done <<-EOF
      AUTO_CD
      CDABLE_VARS
      EOF

      while read -r option; do
        unsetopt $option
      done <<-EOF
      FLOW_CONTROL
      MENU_COMPLETE
      EOF
    '';

    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-history-substring-search"
        "zsh-users/zsh-completions"

        "Aloxaf/fzf-tab"
        "hlissner/zsh-autopair"
        "MichaelAquilina/zsh-you-should-use"
        "jeffreytse/zsh-vi-mode"
      ];
    };
  };
}
