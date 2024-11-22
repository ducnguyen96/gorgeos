{
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
}
