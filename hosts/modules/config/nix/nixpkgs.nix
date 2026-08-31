{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "ventoy-1.1.10"
    ];
    overlays = [
      (import ./overlays/bun.nix)
      inputs.claude-code-overlay.overlays.default
    ];
  };
}
