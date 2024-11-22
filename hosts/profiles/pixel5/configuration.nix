{pkgs, ...}: {
  # user configuration
  user = {
    shell = "${pkgs.zsh}/bin/zsh";
  };

  # nerd font
  terminal.font = ../../../assets/fonts/FiraCodeNerdFont-Medium.ttf;

  # Set your time zone
  time.timeZone = "Asia/Ho_Chi_Minh";

  environment = {
    # Remove welcome
    motd = null;

    # Backup etc files instead of failing to activate generation if a file already exists in /etc
    etcBackupExtension = ".bak";

    # Root packags
    packages = with pkgs; [
      cloudflared
    ];
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    substituters = [
      "https://cache.nixos.org?priority=10"
      "https://nix-community.cachix.org"
      "https://ducnguyen96.cachix.org"
    ];

    trustedPublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ducnguyen96.cachix.org-1:0Dr87meLg1d8ag+V7a0VYckB6uBwWcmNyW5zXpaO1xY="
    ];
  };

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
  system.stateVersion = "24.05"; # Did you read the comment?
}
