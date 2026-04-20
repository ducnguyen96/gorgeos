{
  homebrew = {
    enable = true;

    onActivation = {
      # autoUpdate = true; # Updates Homebrew itself during rebuild
      # upgrade = true; # Upgrades existing packages to the latest version
      cleanup = "zap"; # Uninstalls packages NOT listed in your nix config
    };

    brews = [
      "docker"
      "docker-compose"
      "colima"
      "lazysql"
      "postgresql@18"
      "iproute2mac"

      # aseprite build dependencies
      "ninja"
      "cmake"
    ];

    casks = [
      {name = "cursor";}
      {name = "font-jetbrains-mono";}
      {name = "slack";}
      {name = "godot";}
      {name = "alt-tab";}
      {name = "bruno";}
      {name = "blender";}
      {name = "antigravity";}
      {name = "monitorcontrol";}
    ];
  };
}
