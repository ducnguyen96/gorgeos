{
  programs.hyprland = {
    enable = true;
  };

  environment.variables.NIXOS_OZONE_WL = "1";

  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];

    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
  };
}
