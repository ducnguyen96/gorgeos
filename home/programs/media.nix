{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./imv.nix
  ];

  home.packages = with pkgs; [
    pulsemixer
    mpc-cli
  ];

  programs = {
    mpv = {
      enable = true;
      bindings = {
        UP = "add volume +2";
        DOWN = "add volume -2";
      };
      config = {
        hwdec = "auto";
        border = false;
      };
    };

    ncmpcpp = {
      enable = true;
      package = pkgs.ncmpcpp.override {
        visualizerSupport = true;
        clockSupport = true;
        taglibSupport = true;
      };
      mpdMusicDir = "${config.home.homeDirectory}/Music";
      settings = {
      };
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [wlrobs];
    };
  };

  services = {
    mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
      dataDir = "${config.home.homeDirectory}/.config/mpd";
      extraConfig = ''
        auto_update           "yes"
        restore_paused        "yes"
        audio_output {
          type "pipewire"
          name "My PipeWire Output"
        }
      '';

      # Optional:
      network.listenAddress = "any"; # if you want to allow non-localhost connections
      network.startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
    };
  };

  xdg.mimeApps.defaultApplications = {
    "audio/*" = "ncmpcpp.desktop";
    "video/*" = "mpv.desktop";
    "image/*" = "imv.desktop";
  };
}
