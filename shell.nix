{ pkgs ? import <nixpkgs> {
  config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };
} }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "22.0";
    toolsVersion = "26.1.1";
    platformToolsVersion = "37.0.1";
    buildToolsVersions = [ "34.0.0" ];
    platformVersions = [ "34" ];
    includeEmulator = false;
    includeSources = false;
    includeSystemImages = false;
    useGoogleAPIs = false;
    useGoogleTVAddOns = false;
    includeNDK = false;
  };
  androidSdk = androidComposition.androidsdk;
in
pkgs.mkShell {
  name = "sicos-watchface-env";

  buildInputs = [
    androidSdk
    pkgs.jdk17
    pkgs.gradle
    pkgs.android-tools
  ];

  shellHook = ''
    export ANDROID_HOME="${androidSdk}/libexec/android-sdk"
    export ANDROID_SDK_ROOT="${androidSdk}/libexec/android-sdk"
    export JAVA_HOME="${pkgs.jdk17}"
    export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

    echo "==========================================================="
    echo "  Sicos Watch Face Development Environment (NixOS)"
    echo "  Android SDK: $ANDROID_HOME"
    echo "  Java Home:   $JAVA_HOME"
    echo "  ADB:         $(which adb)"
    echo "==========================================================="
  '';
}
