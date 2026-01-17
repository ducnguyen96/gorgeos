{pkgs, ...}: {
  programs.vscode = {
    enable = true;

    profiles.default = {
      # 1. Extensions: Prettier, ESLint, Live Server, and Language Support
      extensions = with pkgs.vscode-extensions; [
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint
        ritwickdey.liveserver
        formulahendry.auto-rename-tag
        christian-kohler.path-intellisense
      ];

      # 2. Keybindings: Ctrl+O to go back, Ctrl+I to go forward
      keybindings = [
        {
          key = "ctrl+o";
          command = "workbench.action.navigateBack";
        }
        {
          key = "ctrl+i";
          command = "workbench.action.navigateForward";
        }
      ];

      # 3. User Settings: Format on Save and Default Formatters
      userSettings = {
        # --- Font Configuration ---
        "editor.fontFamily" = "'JetBrains Mono', 'Symbols Nerd Font', 'Noto Color Emoji', monospace";
        "editor.fontSize" = 14;
        "editor.fontLigatures" = true; # Highly recommended for JetBrains Mono

        # --- Formatting & Linting ---
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.codeActionsOnSave" = {
          "source.fixAll.eslint" = "explicit";
        };

        # --- Language Specifics ---
        "[javascript]" = {"editor.defaultFormatter" = "esbenp.prettier-vscode";};
        "[html]" = {"editor.defaultFormatter" = "esbenp.prettier-vscode";};

        # --- Extensions ---
        "liveServer.settings.donotShowInfoMsg" = true;
      };
    };
  };
}
