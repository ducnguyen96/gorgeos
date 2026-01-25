{
  imports = [
    ./packages.nix
  ];

  environment = {
    localBinInPath = true;
    pathsToLink = ["/share/zsh"];
  };
}
