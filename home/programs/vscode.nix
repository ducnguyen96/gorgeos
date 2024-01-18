{
  default,
  pkgs,
  ...
}: let
  mimeTypes = [
    "application/javascript"
    "application/sql"
    "application/toml"
    "application/x-shellscript"
    "application/yaml"
    "text/css"
    "text/english"
    "text/html"
    "text/javascript"
    "text/markdown"
    "text/plain"
    "text/rust"
    "text/x-c"
    "text/x-c++"
    "text/x-c++hdr"
    "text/x-c++src"
    "text/x-chdr"
    "text/x-cmake"
    "text/x-csrc"
    "text/x-go"
    "text/x-java"
    "text/x-kotlin"
    "text/x-lua"
    "text/x-makefile"
    "text/x-python"
    "text/x-scss"
  ];
in {
  xdg.mimeApps.defaultApplications = builtins.listToAttrs (map (mimeType: {
      name = mimeType;
      value = ["code.desktop"];
    })
    mimeTypes);

  home.packages = with pkgs; [
    shfmt # foxundermoon.shell-format's depedency
  ];

  programs.vscode = let
    xcolors = pkgs.lib.colors.xcolors default.colorscheme.colors;
  in {
    enable = true;
    mutableExtensionsDir = true;
    extensions =
      (with pkgs.vscode-extensions; [
        ])
      ++ (with pkgs.vscode-marketplace-release; [
        eamodio.gitlens
      ])
      ++ (with pkgs.vscode-marketplace; [
        bbenoist.nix
        catppuccin.catppuccin-vsc-icons
        christian-kohler.path-intellisense
        dbaeumer.vscode-eslint
        editorconfig.editorconfig
        esbenp.prettier-vscode
        foxundermoon.shell-format
        github.copilot
        github.copilot-chat
        kamadorueda.alejandra
        mkhl.direnv
        shardulm94.trailing-spaces
        timonwong.shellcheck
        yzhang.markdown-all-in-one
        hashicorp.terraform
        antfu.icons-carbon
      ])
      ++ [
        (pkgs.catppuccin-vsc.override {
          accent = "blue";
          boldKeywords = true;
          italicComments = true;
          italicKeywords = true;
          extraBordersEnabled = true;
          workbenchMode = "default";
          bracketMode = "rainbow";
          colorOverrides = {
            all = {
              text = "${xcolors.white}";
              base = "${xcolors.black2}";
              mantle = "${xcolors.black1}";
              crust = "${xcolors.black0}";
            };
          };
          customUIColors = {
            all = {
              "statusBar.foreground" = "accent";
              "statusBar.noFolderForeground" = "accent";
            };
          };
        })
      ];

    userSettings = {
      "[c]"."editor.defaultFormatter" = "xaver.clang-format";
      "[cpp]"."editor.defaultFormatter" = "xaver.clang-format";
      "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[less]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[nix]"."editor.defaultFormatter" = "kamadorueda.alejandra";
      "[python]"."editor.defaultFormatter" = "ms-python.black-formatter";
      "[scss]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";

      "breadcrumbs.enabled" = true;
      "breadcrumbs.symbolPath" = "last";

      "editor.acceptSuggestionOnEnter" = "smart";
      "editor.autoIndent" = "full";
      "editor.bracketPairColorization.enabled" = true;
      "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.fontFamily" = "'monospace', monospace, 'Material Design Icons'";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 13;
      "editor.fontWeight" = "500";
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;
      "editor.guides.bracketPairs" = true;
      "editor.guides.indentation" = true;
      "editor.inlayHints.enabled" = "onUnlessPressed";
      "editor.inlayHints.padding" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.linkedEditing" = true;
      "editor.lineHeight" = 22;
      "editor.lineNumbers" = "on";
      "editor.minimap.enabled" = false;
      "editor.minimap.renderCharacters" = false;
      "editor.renderLineHighlight" = "all";
      "editor.renderWhitespace" = "none";
      "editor.semanticHighlighting.enabled" = true;
      "editor.showUnused" = true;
      "editor.smoothScrolling" = true;
      "editor.tabCompletion" = "on";
      "editor.tabSize" = 2;
      "editor.trimAutoWhitespace" = true;
      "editor.wordWrap" = "on";

      "files.autoSave" = "onFocusChange";
      "files.insertFinalNewline" = true;
      "files.trimTrailingWhitespace" = true;

      "files.associations" = {
        "*.inc" = "php";
      };

      "git.autofetch" = true;
      "git.enableSmartCommit" = true;

      "github.copilot.enable" = {
        "*" = true;
      };
      "githubPullRequests.pullBranch" = "always";

      "gitlens.views.repositories.files.layout" = "tree";

      "gopls" = {
        "ui.semanticTokens" = true;
      };

      "shellformat.path" = "${pkgs.shfmt}/bin/shfmt";

      "terminal.integrated.cursorBlinking" = true;
      "terminal.integrated.cursorStyle" = "line";
      "terminal.integrated.cursorWidth" = 2;
      "terminal.integrated.fontFamily" = "'monospace'";
      "terminal.integrated.fontSize" = 13;
      "terminal.integrated.minimumContrastRatio" = 1;
      "terminal.integrated.smoothScrolling" = true;
      "terminal.integrated.defaultProfile.linux" = "zsh";

      "window.autoDetectColorScheme" = true;
      "window.menuBarVisibility" = "toggle";
      "window.titleBarStyle" = "custom";
      "window.zoomLevel" = 1;

      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.editor.enablePreview" = false;
      "workbench.editor.enablePreviewFromQuickOpen" = false;
      "workbench.iconTheme" = "catppuccin-macchiato";
      "workbench.productIconTheme" = "icons-carbon";
      "workbench.tree.renderIndentGuides" = "always";
      "workbench.startupEditor" = "none";
      "workbench.sideBar.location" = "left";
      "workbench.panel.defaultLocation" = "left";
    };

    # https://code.visualstudio.com/shortcuts/keyboard-shortcuts-linux.pdf
    keybindings = [
      {
        "key" = "alt+left";
        "command" = "workbench.action.navigateBack";
        "when" = "canNavigateBack";
      }
      {
        "key" = "alt+right";
        "command" = "workbench.action.navigateForward";
        "when" = "canNavigateForward";
      }
      {
        "key" = "ctrl+g ctrl+d";
        "command" = "editor.action.revealDefinition";
        "when" = "editorHasDefinitionProvider && editorTextFocus && !isInEmbeddedEditor";
      }
      {
        "key" = "ctrl+g ctrl+l";
        "command" = "workbench.action.gotoLine";
      }
    ];
  };
}
