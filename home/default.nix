{
  _module.args = {
    homeImports = {
      "duc@desktop" = [./profiles/duc-desktop.nix];
      "duc@cloud" = [./profiles/duc-cloud.nix];
    };
  };
}
