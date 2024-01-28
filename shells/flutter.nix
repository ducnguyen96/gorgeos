{
  description = "Flutter devShell";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          android_sdk.accept_license = true;
          allowUnfree = true;
        };
      };
      buildToolsVersion = "34.0.0";
      androidComposition = pkgs.androidenv.composeAndroidPackages {
        buildToolsVersions = [buildToolsVersion];
        platformVersions = ["33"];
        abiVersions = ["arm64-v8a"];
      };
      androidSdk = androidComposition.androidsdk;
    in rec {
      devShell = pkgs.mkShell rec {
        ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
        buildInputs = with pkgs; [
          flutter
          androidSdk
          jdk17
        ];
      };
    });
}
