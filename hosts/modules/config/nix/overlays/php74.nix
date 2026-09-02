# PHP 7.4 is EOL and was dropped from nixpkgs after 22.05, so pull it from a
# pinned nixpkgs. Everything but the final php wrapper comes from cache.nixos.org.
{inputs}: _final: prev: let
  pkgs74 = import inputs.nixpkgs-php74 {
    inherit (prev.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };
in {
  inherit (pkgs74) php74;
  php74Packages = pkgs74.php74.packages;
}
