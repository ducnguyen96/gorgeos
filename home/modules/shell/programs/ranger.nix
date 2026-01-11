{pkgs, ...}: let
  editor = "nvim";
in {
  programs.ranger = {
    enable = true;

    settings = {
      column_ratios = "1,3,3";
      confirm_on_delete = "never";
      scroll_offset = 8;
      unicode_ellipsis = true;
      preview_images = true;
      preview_images_method = "kitty";
    };

    mappings = {
      cz = "console z%space";
      yc = "shell wl-copy < %f";
      "<C-f>" = "fzf_select";
      "<C-d>" = "fzf_select_dir";
    };

    plugins = [
      {
        name = "zoxide";
        src = builtins.fetchGit {
          url = "https://github.com/jchook/ranger-zoxide.git";
          rev = "aefff2797b8e3999f659176dc99d76f7186ccc29";
        };
      }
    ];

    extraConfig = ''
      # Custom fzf commands
      import subprocess
      import os
      from ranger.api.commands import Command

      class fzf_select(Command):
          """
          :fzf_select
          Find a file using fzf.
          """
          def execute(self):
              command = "fd --type f --follow --hidden --exclude .git | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
              fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
              stdout, stderr = fzf.communicate()
              if fzf.returncode == 0:
                  fzf_file = os.path.abspath(stdout.strip())
                  if os.path.isfile(fzf_file):
                      self.fm.select_file(fzf_file)

      class fzf_select_dir(Command):
          """
          :fzf_select_dir
          Find a directory using fzf.
          """
          def execute(self):
              command = "fd --type d --follow --hidden --exclude .git | fzf --preview 'eza -la --color=always --icons --tree --level=2 --git-ignore {}'"
              fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
              stdout, stderr = fzf.communicate()
              if fzf.returncode == 0:
                  fzf_dir = os.path.abspath(stdout.strip())
                  if os.path.isdir(fzf_dir):
                      self.fm.cd(fzf_dir)
    '';

    rifle = [
      # Websites
      {
        condition = "ext x?html?, has qutebrowser, X, flag f";
        command = "qutebrowser -- \"$@\"";
      }
      {
        condition = "ext x?html?, has firefox, X, flag f";
        command = "firefox -- \"$@\"";
      }
      {
        condition = "ext x?html?, has chromium, X, flag f";
        command = "chromium -- \"$@\"";
      }
      {
        condition = "ext x?html?, has w3m, terminal";
        command = "w3m \"$@\"";
      }

      # Text files
      {
        condition = "mime ^text, label editor";
        command = "${editor} -- \"$@\"";
      }
      {
        condition = "mime ^text, label pager";
        command = "$PAGER -- \"$@\"";
      }
      {
        condition = "!mime ^text, label editor, ext xml|json|csv|tex|py|pl|rb|rs|js|sh|php|dart";
        command = "${editor} -- \"$@\"";
      }

      # Scripts
      {
        condition = "ext py";
        command = "python -- \"$1\"";
      }
      {
        condition = "ext pl";
        command = "perl -- \"$1\"";
      }
      {
        condition = "ext rb";
        command = "ruby -- \"$1\"";
      }
      {
        condition = "ext js";
        command = "node -- \"$1\"";
      }
      {
        condition = "ext sh";
        command = "sh -- \"$1\"";
      }
      {
        condition = "ext php";
        command = "php -- \"$1\"";
      }
      {
        condition = "ext dart";
        command = "dart run -- \"$1\"";
      }

      # Audio/Video
      {
        condition = "mime ^video|^audio, has mpv, X, flag f";
        command = "mpv -- \"$@\"";
      }
      {
        condition = "mime ^video|^audio, has vlc, X, flag f";
        command = "vlc -- \"$@\"";
      }
      {
        condition = "mime ^audio|ogg$, terminal, has mpv";
        command = "mpv -- \"$@\"";
      }

      # Documents
      {
        condition = "ext pdf, has zathura, X, flag f";
        command = "zathura -- \"$@\"";
      }
      {
        condition = "ext pdf, has mupdf, X, flag f";
        command = "mupdf \"$@\"";
      }
      {
        condition = "ext pdf, has evince, X, flag f";
        command = "evince -- \"$@\"";
      }
      {
        condition = "ext pptx?|od[dfgpst]|docx?|sxc|xlsx?|xlt|xlw|gnm|gnumeric, has libreoffice, X, flag f";
        command = "libreoffice \"$@\"";
      }
      {
        condition = "ext djvu, has zathura, X, flag f";
        command = "zathura -- \"$@\"";
      }
      {
        condition = "ext epub, has zathura, X, flag f";
        command = "zathura -- \"$@\"";
      }

      # Images
      {
        condition = "mime ^image, has imv, X, flag f";
        command = "imv -- \"$@\"";
      }
      {
        condition = "mime ^image, has sxiv, X, flag f";
        command = "sxiv -- \"$@\"";
      }
      {
        condition = "mime ^image, has feh, X, flag f, !ext gif";
        command = "feh -- \"$@\"";
      }
      {
        condition = "mime ^image, has gimp, X, flag f";
        command = "gimp -- \"$@\"";
      }
      {
        condition = "ext xcf, X, flag f";
        command = "gimp -- \"$@\"";
      }

      # Archives
      {
        condition = "ext 7z, has 7z";
        command = "7z -p l \"$@\" | $PAGER";
      }
      {
        condition = "ext ace|ar|arc|bz2?|cab|cpio|cpt|deb|dgc|dmg|gz, has atool";
        command = "atool --list --each -- \"$@\" | $PAGER";
      }
      {
        condition = "ext iso|jar|msi|pkg|rar|shar|tar|tgz|xar|xpi|xz|zip, has atool";
        command = "atool --list --each -- \"$@\" | $PAGER";
      }
      {
        condition = "ext 7z|ace|ar|arc|bz2?|cab|cpio|cpt|deb|dgc|dmg|gz, has atool";
        command = "atool --extract --each -- \"$@\"";
      }
      {
        condition = "ext iso|jar|msi|pkg|rar|shar|tar|tgz|xar|xpi|xz|zip, has atool";
        command = "atool --extract --each -- \"$@\"";
      }

      # Fallback
      {
        condition = "label open, has xdg-open";
        command = "xdg-open \"$@\"";
      }
      {
        condition = "!mime ^text, !ext xml|json|csv|tex|py|pl|rb|rs|js|sh|php|dart";
        command = "ask";
      }
      {
        condition = "label editor, !mime ^text, !ext xml|json|csv|tex|py|pl|rb|rs|js|sh|php|dart";
        command = "${editor} -- \"$@\"";
      }
      {
        condition = "mime application/x-executable";
        command = "\"$1\"";
      }
    ];
  };

  home.packages = with pkgs; [
    xclip
    wl-clipboard
    fd
    fzf
    bat
    eza
  ];
}
