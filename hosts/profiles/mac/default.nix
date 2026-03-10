{
  inputs,
  self,
  ...
}: let
  inherit (inputs.nix-darwin.lib) darwinSystem;
  specialArgs = {inherit inputs self;};
in {
  flake.darwinConfigurations = {
    mac = darwinSystem {
      inherit specialArgs;

      modules = [
        ./nix.nix
        ./environment.nix
        ./programs.nix
        ./homebrew.nix

        ../../modules/services/skhd.nix
        ../../modules/services/yabai.nix
        {
          services.openssh = {
            enable = true;
          };
          users.users.duc.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGNbn8ULX8j+jDdAEUkn9++ol6QR57rrpTURo7FcaBF duc@master"
          ];
          users.users.root.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGNbn8ULX8j+jDdAEUkn9++ol6QR57rrpTURo7FcaBF duc@master"
          ];
        }
      ];
    };
  };
}
