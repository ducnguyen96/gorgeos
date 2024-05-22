[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

<div align="center">

<a href="#">
  <img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nixos.svg" width="750" height="300" alt="Banner"/>
</a>

<br>

<a href="#">
  <img src="./assets/preview.png" width="800" alt="Desktop Preview"/>
</a>

<br>

<br>

</div>

> **Profiles:**
>
> - **OS:** NixOS
> - **Window Manager:**
>   - Hyprland
> - **Shell:**:
>   - ZSH
> - **Terminal:**:
>   - Kitty
> - **Editor:**
>   - Neovim
>   - Visual Studio Code
> - **Shell:**
>   - Nodejs

## :package: Repository Contents

- **[Flake](./flake):** configurations for code formatting, and pre-commit hooks.
- **[Home](./home):** [Home-Manager](https://github.com/nix-community/home-manager) configurations.
- **[Hosts](./hosts):** Configurations specific to individual hosts.
- **[Lib](./lib):** Personal library and utilities.
- **[Modules](./modules):** Shared system-wide modules.
- **[pkgs](./pkgs):** Customized and additional packages.
- **[shells](./shells/)** Shell templates to reuse

## :hammer: Install

After boot to Nix installation.

### [Optional] Connect wifi

```bash
systemctl start wpa_supplicant
wpa_cli
```

```bash
scan
add_network
set_network 0 ssid "wifi-name"
set_network 0 psk "wifi-password"
enable_network 0
save_config
reconnect
```

Then `CTRL-D` to exit.

### Clone repo

```bash
nix-shell -p git
git clone https://ducnguyen96/gorgeos
```

### Disk partioning and mounting

- Modify [disko-config](./misc/disko/disko-config.nix) as you want. Full guide [here](https://github.com/nix-community/disko/blob/master/docs/quickstart.md)
- Run
  ```bash
  ./misc/disko/run
  ```

### Customize host and home

#### Host

You can cp [hosts/e14g2](./hosts/e14g2) to your own host for example:

```bash
cp -r hosts/e14g2 hosts/8570w
```

Then generate your hardware config

```bash
nixos-generate-config --root /mnt
```

Copy the hardware config to your host

```bash
cp /mnt/etc/nixos/hardware-configuration.nix hosts/8570w
```

Add your host to the flake
[!NOTE]: Replace user below with your user `home-manager.users.<your-user>.imports = ...`

`hosts/default.nix`

```nix
{
  homeImports,
  inputs,
  self,
  themes,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  modules = "${self}/modules/system";
  hardware = modules + "/hardware";
  profiles = "${self}/hosts/profiles";

  specialArgs = {inherit inputs self themes;};
in {
  flake.nixosConfigurations = {
    8570w = nixosSystem {
      inherit specialArgs;

      modules = [
        ./8570w

        "${modules}/config"
        "${modules}/programs"
        "${modules}/security"
        "${modules}/services"
        "${modules}/virtualization/docker.nix"
        "${hardware}/bluetooth.nix"
        "${hardware}/intel.nix"
        "${hardware}/amd.nix"
        "${profiles}/hyprland"

        {
          home-manager = {
            users.duc.imports = homeImports."duc@hyprland";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
```

Replace the user in:

- [modules/system/config/users-group.nix](modules/system/config/users-group.nix)
- [home/default.nix](home/default.nix)
- [home/home.nix](home/home.nix)

### Home

You can modify the [existing profile](home/profiles/hyprland) or add a new profile as follow:

```bash
touch home/profiles/new-profile.nix
```

Add the profile to the flex

`home/default.nix`

```nix
flake = {
  homeConfigurations = withSystem "x86_64-linux" ({pkgs, ...}: {
    "duc@hyprland" = homeManagerConfiguration {
        inherit pkgs;
        modules = homeImports."duc@hyprland";
      };
    "new-profile" = homeManagerConfiguration {
      inherit pkgs;
    };
  });
};
```

Then you can use the profile for your host
`hosts/default.nix`

```nix
8570w = nixosSystem {
  modules =
    [
      ./8570w
      ../modules/hardware/audio
      ../modules/hardware/gpu/intel.nix
      self.nixosModules.hyprland
      {home-manager.users.<your-user>.imports = homeImports."new-profile";}
    ];
};
```

### `nixos-install`

After updating host and home as you like you can install the whole thing with

`8570w` here is your host

```bash
nixos-install --flake .#8570w
```

It will take a while. Then after that you can reboot.

## Daily usages

### Rebuild

```bash
# note that rebuild script assume your flake is in the same directory as this repo which is ~/Documents/Code/gorgeos
rebuild
```

### Delete system old generations

```bash
sudo nix-collect-garbage -d
```

### Delete home old generations

```bash
nix-collect-garbage -d
```
