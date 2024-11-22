{
  homeImports,
  inputs,
  self,
  themes,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  specialArgs = {inherit inputs self themes;};
in {
  flake.nixosConfigurations = {
    rpi4 = nixosSystem {
      inherit specialArgs;
      system = "aarch64-linux";

      modules = [
        inputs.raspberry-pi-nix.nixosModules.raspberry-pi
        inputs.raspberry-pi-nix.nixosModules.sd-image

        # must have
        ./configuration.nix

        # must have at least config/nix
        ../../modules/config/nix
        ../../modules/config/fonts
        ../../modules/config/console.nix
        ../../modules/config/i18n.nix
        ../../modules/config/locale.nix
        ../../modules/config/users.nix

        # environment

        # hardware
        ../../modules/hardware/raspberry-pi.nix

        # programs, must have at least programs/home-manager
        ../../modules/programs/home-manager.nix

        # security
        ../../modules/security

        # services, should have at least services/networking
        {
          environment.systemPackages = [inputs.nixpkgs.legacyPackages.aarch64-linux.cloudflared];
          services.cloudflared = {
            enable = true;
            tunnels = {
              # use cloudflared tunnels create to create a tunnel
              adc7fa2a-1fc8-4f3a-b023-4f3e8289db6b = {
                default = "http_status:404";
                # we will migration this tunnel to remotely-managed tunnel then config ingress,... via https://one.dash.cloudflared.com

                # mkdir -p /tmp/keys/cloudflared
                # cp /root/.cloudflared/adc7fa2a-1fc8-4f3a-b023-4f3e8289db6b.json /tmp/keys/cloudflared
                # chown -R cloudflared:cloudflared /tmp/keys/cloudflared
                credentialsFile = "/tmp/keys/cloudflared/adc7fa2a-1fc8-4f3a-b023-4f3e8289db6b.json";
              };
            };
          };
        }
        ../../modules/services/networking.nix
        ../../modules/services/openssh.nix
        ../../modules/services/keyd.nix

        {
          home-manager = {
            users.duc.imports = homeImports."duc@rpi4";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
