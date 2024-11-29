{
  config,
  lib,
  pkgs,
  ...
}: {
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

    autosuggestion = {
      enable = true;
      strategy = ["history" "completion"];
      highlight = "fg=153";
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern" "cursor" "regexp" "root" "line"];
    };

    historySubstringSearch = {
      enable = true;
      searchUpKey = ["^[[A"];
      searchDownKey = ["^[[B"];
    };

    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      size = 10000;
      save = 10000;
      append = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      extended = true;
      share = true;
    };

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      LC_ALL = "en_US.UTF-8";
      PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = 1;
    };

    initExtraBeforeCompInit = ''
      fpath+=(${pkgs.zsh-completions}/share/zsh/site-functions)
    '';

    completionInit = ''
      zmodload zsh/complist
      autoload -U compinit;
      if [[ $(find ~/.config/zsh/.zcompdump -mmin +1440 2>/dev/null) ]]; then
        compinit;
      else
        compinit -C;
      fi;
      _comp_options+=(globdots)
    '';

    initExtra = ''
      while read -r option; do
        setopt $option
      done <<-EOF
      ALWAYS_TO_END
      AUTO_CD
      AUTO_LIST
      AUTO_MENU
      AUTO_PARAM_SLASH
      AUTO_PUSHD
      CDABLE_VARS
      COMPLETE_IN_WORD
      HASH_LIST_ALL
      INTERACTIVE_COMMENTS
      NO_BEEP
      NOTIFY
      PATH_DIRS
      PUSHD_IGNORE_DUPS
      PUSHD_SILENT
      EOF

      while read -r option; do
        unsetopt $option
      done <<-EOF
      FLOW_CONTROL
      MENU_COMPLETE
      EOF

      # Ztyle pattern
      # :completion:<function>:<completer>:<command>:<argument>:<tag>

      zstyle ':completion:*' completer _complete _ignored _approximate
      zstyle ':completion:*' complete true
      zstyle ':completion:*' complete-options true
      zstyle ':completion:*' file-sort modification
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' keep-prefix true
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
      zstyle ':completion:*' verbose true

      zstyle ':completion:*:default' list-prompt '%S%M matches%s'
      zstyle ':completion:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
      zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
      zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
      zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
    '';

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

    plugins = with pkgs; [
      {
        name = "zsh-fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
      {
        name = "zsh-you-should-use";
        src = pkgs.zsh-you-should-use;
        file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };
}
