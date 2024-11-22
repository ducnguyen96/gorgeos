{
  _module.args = {
    homeImports = {
      "duc@e14g2" = [./profiles/duc-e14g2.nix];
      "duc@minimal" = [./profiles/duc-minimal.nix];
      "duc@rpi4" = [./profiles/duc-rpi4.nix];
      "duc@rtx2070" = [./profiles/duc-rtx2070.nix];
      "pixel5" = ./profiles/pixel5.nix;
    };
  };
}
