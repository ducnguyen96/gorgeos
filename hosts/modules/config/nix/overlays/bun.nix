final: prev: let
  bunVersion = "1.4.0"; # Adjust exact version if needed (e.g., 1.4.1)

  bunArch =
    {
      "x86_64-linux" = "x64";
      "aarch64-linux" = "aarch64";
      "aarch64-darwin" = "aarch64";
      "x86_64-darwin" = "x64";
    }.${
      prev.stdenv.hostPlatform.system
    };

  bunOs =
    {
      "x86_64-linux" = "linux";
      "aarch64-linux" = "linux";
      "aarch64-darwin" = "darwin";
      "x86_64-darwin" = "darwin";
    }.${
      prev.stdenv.hostPlatform.system
    };

  bunHash =
    {
      "x86_64-linux" = "sha256-LQP7X7g6yLVnrKCigbLOGhoZ1Ij1bClo2Iw/Jekv5FI=";
      "aarch64-darwin" = "sha256-xmnpf2Fk4cluBwF0jbmN+ndJKQjL2DlMdVcTSnNd44E=";
    }.${
      prev.stdenv.hostPlatform.system
    };
in {
  bun = prev.stdenv.mkDerivation {
    pname = "bun";
    version = bunVersion;

    src = prev.fetchurl {
      url = "https://github.com/oven-sh/bun/releases/download/bun-v${bunVersion}/bun-${bunOs}-${bunArch}.zip";
      hash = bunHash;
    };

    nativeBuildInputs = [prev.unzip];

    installPhase = ''
      mkdir -p $out/bin
      cp bun $out/bin/bun
      chmod +x $out/bin/bun
    '';

    postFixup = prev.lib.optionalString prev.stdenv.isLinux ''
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/bun
    '';
  };
}
