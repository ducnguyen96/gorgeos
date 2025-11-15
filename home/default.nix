{
  _module.args = {
    homeImports = {
      "duc@e14g2" = [./profiles/duc-e14g2.nix];
      "duc@minimal" = [./profiles/duc-minimal.nix];
      "duc@cloud" = [./profiles/duc-cloud.nix];
      "duc@rtx2070" = [./profiles/duc-rtx2070.nix];
    };
  };
}
