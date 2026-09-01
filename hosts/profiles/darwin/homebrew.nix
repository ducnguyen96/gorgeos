{
  homebrew = {
    enable = true;

    onActivation = {
      # autoUpdate = true; # Updates Homebrew itself during rebuild
      # upgrade = true; # Upgrades existing packages to the latest version
      # cleanup = "zap"; # Uninstalls packages NOT listed in your nix config
    };

    brews = [
      "docker"
      "docker-compose"
      "colima"
      "lazysql"
      "iproute2mac"
      "railway"
      "ffmpeg"

      # aseprite build dependencies
      "ninja"
      "cmake"

      "zbar"
      "gauth"
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
      {name = "ngrok";}
      {name = "google-chrome";}
    ];
  };
}
