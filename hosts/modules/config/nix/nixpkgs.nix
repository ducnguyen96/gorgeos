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
            url = "https://packages.microsoft.com/ubuntu/24.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.3_amd64.deb";
            sha256 = "sha256-vorPf5pvNLABwntiDdfDSiubg1jbHaKK/o0fFkbZ000=";
          };
          buildPhase = ''
            runHook preBuild
            # Remove jnr-posix jar files if they exist (non-fatal for version 2.0.3)
            rm -f opt/microsoft/identity-broker/lib/jnr-posix-*.jar 2>/dev/null || true
            runHook postBuild
          '';
          installPhase = ''
            runHook preInstall
            
            # Install opt/microsoft/identity-broker if it exists
            if [ -d "opt/microsoft/identity-broker" ]; then
              mkdir -p $out/lib/microsoft-identity-broker
              cp -r opt/microsoft/identity-broker/* $out/lib/microsoft-identity-broker/ 2>/dev/null || true
            fi
            
            # Install usr/bin files
            if [ -d "usr/bin" ]; then
              mkdir -p $out/bin
              cp -r usr/bin/* $out/bin/ 2>/dev/null || true
            fi
            
            # Install usr/lib files (including systemd services)
            if [ -d "usr/lib" ]; then
              mkdir -p $out/lib
              cp -r usr/lib/* $out/lib/ 2>/dev/null || true
            fi
            
            # Install lib/systemd files if they exist (alternative location)
            if [ -d "lib/systemd" ]; then
              mkdir -p $out/lib/systemd
              cp -r lib/systemd/* $out/lib/systemd/ 2>/dev/null || true
            fi
            
            # Install usr/share files if they exist
            if [ -d "usr/share" ]; then
              mkdir -p $out/share
              cp -r usr/share/* $out/share/ 2>/dev/null || true
            fi
            
            runHook postInstall
          '';
          postInstall = ''
            runHook prePostInstall
            # Version 2.0.3 may not have the systemd service file that the original postInstall expects
            # Only run substitution if the file exists
            SERVICE_FILE="$out/lib/systemd/user/microsoft-identity-broker.service"
            if [ -f "$SERVICE_FILE" ]; then
              # Run the original postInstall which does the substitution
              ${previousAttrs.postInstall or "true"}
            else
              # Skip postInstall if service file doesn't exist (version 2.0.3 compatibility)
              echo "Skipping postInstall: systemd service file not found (expected for version 2.0.3)"
            fi
            runHook postPostInstall
          '';
        });
      })
    ];
    hostPlatform = "x86_64-linux";
  };
}
