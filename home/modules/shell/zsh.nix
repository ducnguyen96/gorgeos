{
  config,
  lib,
  pkgs,
  themes,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    dirHashes = {
      dl = "$HOME/Downloads";
      docs = "$HOME/Documents";
      pics = "$HOME/Pictures";
      vids = "$HOME/Videos";
      mss = "$HOME/Music";
      code = "$HOME/Documents/Code";
    };

    autosuggestion = {
      enable = true;
      strategy = ["history" "completion"];
      highlight = "fg=153";
    };

    autocd = true;

    enableCompletion = true;

    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern" "cursor" "regexp" "root" "line"];
    };

    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
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
      # Load zsh modules
      zmodload zsh/complist

      # Enabling the Zsh Completion System
      autoload -Uz compinit;

      if [[ $(find ~/.config/zsh/.zcompdump -mmin +1440 2>/dev/null) ]]; then
        compinit;
      else
        compinit -C;
      fi;

      _comp_options+=(globdots) # With hidden file-sort

      # Set Options
      while read -r option; do
        setopt $option
      done <<-EOF
      AUTO_CD
      AUTO_LIST
      AUTO_MENU
      AUTO_PARAM_SLASH
      AUTO_PUSHD
      APPEND_HISTORY
      ALWAYS_TO_END
      CDABLE_VARS
      COMPLETE_IN_WORD
      CORRECT
      EXTENDED_GLOB
      EXTENDED_HISTORY
      HIST_EXPIRE_DUPS_FIRST
      HIST_FCNTL_LOCK
      HIST_IGNORE_ALL_DUPS
      HIST_IGNORE_DUPS
      HIST_IGNORE_SPACE
      HIST_REDUCE_BLANKS
      HIST_SAVE_NO_DUPS
      HIST_VERIFY
      INC_APPEND_HISTORY
      INTERACTIVE_COMMENTS
      MENU_COMPLETE
      NOBEEP
      NO_NOMATCH
      PUSHD_IGNORE_DUPS
      PUSHD_TO_HOME
      PUSHD_SILENT
      SHARE_HISTORY
      EOF

      while read -r option; do
        unsetopt $option
      done <<-EOF
      CORRECT_ALL
      MENU_COMPLETE
      FLOW_CONTROL
      EOF

      # General
      zstyle ':completion:*' file-sort modification
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' special-dirs true

      # Cache
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

      # Completers
      zstyle ':completion:*' completer _complete _match _approximate
      zstyle ':completion:*:match:*' original only
      zstyle ':completion:*:approximate:*' max-errors 1 numeric

      # Complete the alias
      zstyle ':completion:*' complete true

      # Autocomplete options
      zstyle ':completion:*' complete-options true

      # Completion matching control
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' keep-prefix true

      # Group matches
      zstyle ':completion:*' menu select
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*:matches' group 'yes'
      zstyle ':completion:*:options' description 'yes'

      # Colors
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

      # Format
      zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
      zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
      zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
      zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

      # Sort
      zstyle ':completion:*' sort false
      zstyle ':completion:*:eza' sort false
      zstyle ':completion:*:git-checkout:*' sort false
      zstyle ':completion:files' sort false
      zstyle ':completion:complete:*:options' sort false

      # fzf-tab
      zstyle ':fzf-tab:complete:*:*' fzf-preview 'preview $realpath'
      zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
      zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
      zstyle ':fzf-tab:*' fzf-command fzf
      zstyle ':fzf-tab:*' fzf-pad 4
      zstyle ':fzf-tab:*' fzf-min-height 100
      zstyle ':fzf-tab:*' switch-group ',' '.'
    '';

    envExtra = let
      inherit (themes.colorscheme) xcolors;
    in ''
      # Set fzf options
      export FZF_DEFAULT_OPTS=" \
      --multi \
      --cycle \
      --reverse \
      --bind='ctrl-space:toggle,pgup:preview-up,pgdn:preview-down' \
      --ansi \
      --color='fg:${xcolors.gray1},bg:${xcolors.black0},gutter:${xcolors.black3}' \
      --color='fg+:${xcolors.white},bg+:${xcolors.black3},hl:${xcolors.red},hl+:${xcolors.blue}' \
      --color='info:${xcolors.green},border:${xcolors.gray1},prompt:${xcolors.blue},pointer:${xcolors.mauve}' \
      --color='marker:${xcolors.blue},spinner:${xcolors.mauve},header:${xcolors.green}' \
      --prompt ' ' \
      --pointer '' \
      --marker ''
      "
    '';

    shellAliases = with lib;
    with pkgs; {
      cat = "${getExe bat} --theme=base16 --number --color=always --paging=never --tabs=2 --wrap=never";

      la = "${getExe eza} -lah --tree";
      ls = "${getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";
      tree = "${getExe eza} --tree --icons --tree";

      du = getExe du-dust;
      grep = getExe ripgrep;
      ps = getExe procs;

      cp = "cp -iv";
      rm = "rm -iv";
      mv = "mv -iv";

      g = "git";
      ga = "git add";
      gaa = "git add --all";
      gb = "git branch";
      gc = "git commit -v";
      gcm = "git commit --message";
      gco = "git checkout";
      gd = "git diff";
      gi = "git init";
      gl = "git pull";
      gp = "git push";
      gs = "git status";

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
