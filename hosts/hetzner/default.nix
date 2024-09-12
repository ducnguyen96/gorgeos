{
  imports = [./hardware-configuration.nix];

  networking.hostName = "hetzner";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
}
