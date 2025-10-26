{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    pkgs.chromium
  ];

  android = {
    enable = true;
    platforms.version = [
      "32"
      "34"
    ];
    systemImageTypes = [ "google_apis_playstore" ];
    abis = [
      "arm64-v8a"
      "x86_64"
    ];
    cmake.version = [ "3.22.1" ];
    cmdLineTools.version = "11.0";
    tools.version = "26.1.1";
    platformTools.version = "34.0.5";
    buildTools.version = [ "30.0.3" ];
    emulator = {
      enable = true;
      version = "34.1.9";
    };
    sources.enable = false;
    systemImages.enable = true;
    ndk.enable = true;
    googleAPIs.enable = true;
    googleTVAddOns.enable = true;
    extras = [ "extras;google;gcm" ];

    flutter.enable = true;
  };
  enterShell = ''
    echo "Flutter Dev environement @svdxx"
    export CHROME_EXECUTABLE=$(which chromium)
    export ANDROID_HOME=$(which android | sed -E 's/(.*libexec\/android-sdk).*/\1/')
    export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH

    # Create a symbolic link to the '8.0' directory named 'latest' if it doesn't exist
    # I added this link in to stop `flutter doctor` complaining - not that it matters really
    # It doesn't seem to be required currently - so I commented it out
    #  if [ ! -d "$ANDROID_HOME/cmdline-tools/latest" ]; then
    #    ln -s $ANDROID_HOME/cmdline-tools/8.0 $ANDROID_HOME/cmdline-tools/latest
    #  fi
  '';
}
