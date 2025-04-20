{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./extra-completions
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    dotDir = ".config/zsh";

    dirHashes = {
      dl = "$HOME/Downloads";
      docs = "$HOME/Documents";
      pics = "$HOME/Pictures";
      vids = "$HOME/Videos";
      mss = "$HOME/Music";
      code = "$HOME/Documents/code";
      sides = "$HOME/Documents/code/sides";
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

      du = getExe du-dust;
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

      r = "rebuild";
      n = "nvim --listen /tmp/nvim-server.pipe";
      v = "nvim --listen /tmp/nvim-server.pipe";
      vim = "nvim --listen /tmp/nvim-server.pipe";
      nvim = "nvim --listen /tmp/nvim-server.pipe";

      awsume = ". awsume";
    };

    initExtraBeforeCompInit = ''
      fpath+=("$HOME/.config/zsh/extra-completions")
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
