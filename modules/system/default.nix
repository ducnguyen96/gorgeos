{lib, ...}: {
  imports = [
    ./environment
    ./misc
    ./networking
    ./nix
    ./programs
    ./security
    ./users
  ];

  system.stateVersion = lib.mkDefault "24.05";
}
