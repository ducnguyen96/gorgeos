{pkgs, ...}: {
  imports = [
    ./networking.nix
    ./openssh.nix
    ./pipewire.nix
    ./greetd.nix
    ./keyd.nix
  ];

  services = {};
}
