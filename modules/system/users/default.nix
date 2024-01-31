{pkgs, ...}: let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINuuBrTcxqxvYyug48HCwzba2W+1veFO823Znlidbrrh levinguyen.dl@gmail"
  ];
in {
  users.users.duc = {
    isNormalUser = true;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = keys;
    extraGroups = [
      "adbusers"
      "audio"
      "docker"
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "video"
      "wheel"
    ];
  };
}
