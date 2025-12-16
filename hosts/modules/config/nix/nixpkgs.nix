{pkgs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];

    overlays = [
      (final: prev: {
        microsoft-identity-broker = prev.microsoft-identity-broker.overrideAttrs (previousAttrs: {
          src = pkgs.fetchurl {
            url = "https://packages.microsoft.com/ubuntu/20.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.1_amd64.deb";
            sha256 = "sha256-ftfLS8bJhBYaT7SJ12TqDa+yxKBJnTwMWgs+XxFbsCs=";
          };
        });
      })
    ];
    hostPlatform = "x86_64-linux";
  };
}
