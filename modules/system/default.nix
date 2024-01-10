{lib, ...}: {
  imports = [
    ./environment
    ./misc
    ./networking
    ./nix
    ./security
    ./users
  ];

  system.stateVersion = lib.mkDefault "24.05";
}
