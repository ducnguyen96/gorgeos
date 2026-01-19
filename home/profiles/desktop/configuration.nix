{pkgs, ...}: {
  home = {
    username = "duc";
    homeDirectory = "/home/duc";
    sessionVariables = {
      XDG_SCREENSHOTS_DIR = "/home/duc/Screenshots";
      LD_LIBRARY_PATH = "${pkgs.gcc15.cc.lib}/lib:/run/opengl-driver/lib:LD_LIBRARY_PATH";
    };

    packages = with pkgs; [
      # shotcut # video editor
      remmina # Remote desktop client written in GTK
      # telegram-desktop
      # google-chrome # browser
      # gimp # image editor
      # audacity
      # chromium
      dbeaver-bin # Sql client
      android-tools
      scrcpy
      cloudflare-warp
      slack
      heroku
      postman
      code-cursor
      zip
    ];
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  home.stateVersion = "25.05"; # Did you read the comment?
}
