{
  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "ventoy-1.1.10"
    ];
    overlays = [];
    hostPlatform = "x86_64-linux";
  };
}
