{pkgs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "electron-25.9.0"

      "ventoy-1.1.10"
    ];
    overlays = [];
    hostPlatform = "x86_64-linux";
  };
}
