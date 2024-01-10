{
  lib,
  pkgs,
  ...
}: {
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
    ];
  };

  time = {
    timeZone = lib.mkDefault "Asia/Ho_Chi_Minh";
    hardwareClockInLocalTime = lib.mkDefault true;
  };

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
  };
}
