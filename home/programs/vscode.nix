{
  inputs,
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

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
    ];

    userSettings = {
      "[c]".editor.defaultFormatter = "xaver.clang-format";
      "[cpp]".editor.defaultFormatter = "xaver.clang-format";
      "[css]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[html]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[javascript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
      "[json]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[jsonc]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
      "[lua]".editor.defaultFormatter = "johnnymorganz.stylua";
      "[nix]".editor.defaultFormatter = "kamadorueda.alejandra";
      "[python]".editor.defaultFormatter = "ms-python.black-formatter";
      "[scss]".editor.defaultFormatter = "sibiraj-s.vscode-scss-formatter";
      "[typescript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";

      breadcrumbs.enabled = false;
      editor = {
        bracketPairColorization = {
          enabled = true;
          independentColorPoolPerBracketType = true;
        };
        cursorBlinking = "smooth";
        cursorSmoothCaretAnimation = "on";
        cursorWidth = 2;
        find.addExtraSpaceOnTop = false;
        fontFamily = "'monospace', monospace, 'Material Design Icons'";
        fontLigatures = true;
        fontSize = 13;
        formatOnPaste = true;
        formatOnSave = true;
        formatOnType = true;
        guides = {
          bracketPairs = true;
          indentation = true;
        };
        inlayHints.enabled = "off";
        inlineSuggest.enabled = true;
        largeFileOptimizations = false;
        lineNumbers = "on";
        linkedEditing = true;
        maxTokenizationLineLength = 60000;
        minimap.enabled = false;
        overviewRulerBorder = false;
        quickSuggestions.strings = true;
        renderLineHighlight = "all";
        renderWhitespace = "none";
        smoothScrolling = true;
        suggest.showStatusBar = true;
        suggestSelection = "first";
      };

      emmet.useInlineCompletions = true;
      explorer = {
        confirmDelete = true;
        confirmDragAndDrop = false;
      };

      files = {
        eol = "\n";
        insertFinalNewline = true;
        trimTrailingWhitespace = true;
      };

      git = {
        autofetch = true;
        confirmSync = false;
        enableSmartCommit = true;
      };

      github.copilot.enable."*" = true;
      security.workspace.trust.enabled = false;

      terminal.integrated = {
        cursorBlinking = true;
        cursorStyle = "line";
        cursorWidth = 2;
        fontFamily = "'monospace'";
        fontSize = 13;
        smoothScrolling = true;
        defaultProfile = {
          linux = "zsh";
        };
      };

      window = {
        menuBarVisibility = "toggle";
        nativeTabs = true;
        titleBarStyle = "custom";
        zoomLevel = 1;
      };

      workbench = {
        colorTheme = "Catppuccin Macchiato";
        iconTheme = "material-icon-theme";
        panel.defaultLocation = "left";
        productIconTheme = "material-product-icons";
        sideBar.location = "left";
      };
    };
  };
}
