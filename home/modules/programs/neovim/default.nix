{
  config,
  pkgs,
  ...
}: let
  mimeTypes = [
    "application/javascript"
    "application/sql"
    "application/toml"
    "application/x-shellscript"
    "application/x-php"
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
    "text/x-php"
  ];
in {
  xdg.mimeApps.defaultApplications = builtins.listToAttrs (map (mimeType: {
      name = mimeType;
      value = ["nvim.desktop"];
    })
    mimeTypes);

  home.packages = with pkgs; [
    # dependencies
    cmake
    gnumake
    gcc
    fd
    ripgrep
    wl-clipboard
    tree-sitter
    nodejs
    yarn

    # nix formatter
    alejandra

    # nix language server
    nil
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    withPython3 = true;
    extraPython3Packages = ps: with ps; [python-dotenv requests pynvim prompt-toolkit];
  };

  programs.lazygit = {
    enable = true;
  };

  home.file."${config.home.homeDirectory}/.config/nvim/init.lua" = {
    source = ./config/init.lua;
  };

  home.file."${config.home.homeDirectory}/.config/nvim/lua" = {
    source = ./config/lua;
  };

  home.file."nvim.desktop" = {
    text = ''
      [Desktop Entry]
      Name=Neovim
      Comment=Edit text files
      Exec=kgx -e nvim %F
      Terminal=true
      Type=Application
      Icon=nvim
      Categories=Utility;TextEditor;
    '';

    target = "${config.home.homeDirectory}/.local/share/applications/nvim.desktop";
  };
}
