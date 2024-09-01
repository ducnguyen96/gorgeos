{pkgs, ...}: {
  users.users.duc = {
    isNormalUser = true;
    initialPassword = "NixOS";
    shell = pkgs.zsh;
    uid = 1000;

    extraGroups = [
      "adbusers"
      "audio"
      "docker"
      "input"
      "libvirtd"
      "qemu-libvirtd"
      "networkmanager"
      "plugdev"
      "video"
      "ydotool"
      "wheel"
      "i2c"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINuuBrTcxqxvYyug48HCwzba2W+1veFO823Znlidbrrh levinguyen.dl@gmail"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/7cqLgO9Vz5xLyEhj0S24UncdPRPAM8m98X2ZsBfQQjKk3iCStH2cBAgMLpb27oepVKX4oB2Mh8AvL54NWgMTgqWL3spy2oLYgBDhCd6wjJzvQoNKt0H/f2k1bfjSpacyEZuAJkq6GadoFsFjVxL2+eDHFdfhs6AdupTJfcXoUFIecIokDGIO61iUwN+ZMvOhMdnw7gi4kZsQXByF9orn7pmEGzf3WCd7OAVD26NqPZrN4ltNLHEQzcGrwR5GNy4HYXSoWHgj6jU5+D7//6BtfGIcSecOWGcxery3HaDWVC9NsfnBvjkCWiNhoPCZ1dwf9pxSdITTjug7wslTa8f0MgifExloqj2PQ12TWZtLDTXV+ECU7msHps3WRiVBryMlcEuGlsJvL53/cniYdR2CubPUhX3dsEzjTU3TMcjY6mZKWG2UQhkpBBlUDDX/3lDYf0+15/OacyLV8gE2lYvjwsPgANNpi3JCF4gQuE73VUP1NA6cLgMLUIm/+dOWAoHilMGeKJrURuIzHwqCgEoF43fsDwtsgxas1NqzMzJ5Bl4hyzcGAHya/cg2ZM6nLy6LRHtW+2k1sryAPrq7C2G7X7FfspPfw045J3Xnk4qf1pSldaoTQ6SCBk0X1W2b/rxRTFesPa0T2fPrF1B1k4u14k8msaS7i80dH5F5RQMYDw== levinguyen.dl@gmail.com"
    ];
  };
}
