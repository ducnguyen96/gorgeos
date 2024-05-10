{lib, ...}: {
  time = {
    timeZone = lib.mkDefault "Asia/Ho_Chi_Minh";
    hardwareClockInLocalTime = lib.mkDefault true;
  };
}
