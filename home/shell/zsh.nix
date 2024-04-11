{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    dirHashes = {
      dl = "$HOME/Downloads";
      docs = "$HOME/Documents";
      code = "$HOME/Documents/Code";
      dots = "$HOME/Documents/Code/SideProjects/gorgeos";
      pics = "$HOME/Pictures";
      vids = "$HOME/Videos";
      mss = "$HOME/Music";
    };

    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    history = {
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh_history";
    };

    sessionVariables = {
      LC_ALL = "en_US.UTF-8";
      ZSH_AUTOSUGGEST_USE_ASYNC = "true";
    };

    initExtra = ''
      zstyle ':completion:*' completer _complete _ignored _approximate
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion:*' verbose true
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
      _comp_options+=(globdots)

      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey '^H' backward-kill-word
      bindkey '^[[1~' beginning-of-line
      bindkey '^[[4~' end-of-line
    '';

    shellAliases = with lib;
    with pkgs; {
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      cat = "${getExe bat} --style=plain";
      du = getExe du-dust;
      fzf = getExe skim;
      r = "rebuild";
      n = "nvim --listen /tmp/nvim-server.pipe";
      v = "nvim --listen /tmp/nvim-server.pipe";
      vim = "nvim --listen /tmp/nvim-server.pipe";
      nvim = "nvim --listen /tmp/nvim-server.pipe";
      g = "git";
      ga = "git add";
      gab = "git add . && rebuild";
      gc = "git commit";
      gp = "git push";
      gs = "git status";
      la = "${getExe eza} -lah --tree";
      ls = "${getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";
      ps = getExe procs;
      tree = "${getExe eza} --tree --icons --tree";
      untar = "tar -xvf";
      untargz = "tar -xzf";
      awsume = ". awsume";
      ytmp3 = ''${lib.getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" -o "${config.home.homeDirectory}/Music/youtube/%(title)s.%(ext)s"'';
    };

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
      {
        name = "fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "master";
          sha256 = "sha256-gvZp8P3quOtcy1Xtt1LAW1cfZ/zCtnAmnWqcwrKel6w=";
        };
      }
    ];
  };
}
