{lib, ...}: {
  imports = [
    ./environment
    ./misc
    ./networking
    ./nix
    ./programs
    ./security
    ./users
    ./services
    ./virtualization
  ];

  system.stateVersion = lib.mkDefault "24.05";
}
