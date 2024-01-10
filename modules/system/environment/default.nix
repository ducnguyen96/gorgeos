{pkgs, ...}: {
  imports = [
    ./locale.nix
    ./variables.nix
  ];

  environment = {
    systemPackages = with pkgs; [
    ];
  };
}
