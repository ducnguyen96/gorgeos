{
  homebrew = {
    enable = true;

    onActivation = {
      # autoUpdate = true; # Updates Homebrew itself during rebuild
      # upgrade = true; # Upgrades existing packages to the latest version
      cleanup = "zap"; # Uninstalls packages NOT listed in your nix config
    };

    casks = [
      {name = "font-jetbrains-mono";}
      {name = "slack";}
      {name = "godot";}
    ];
  };
}
