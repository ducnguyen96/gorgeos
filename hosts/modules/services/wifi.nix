{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.networking.networkmanager;

  getFileName = stringAsChars (x:
    if x == " "
    then "-"
    else x);

  createWifi = ssid: opt: {
    name = ''
      NetworkManager/system-connections/${getFileName ssid}.nmconnection
    '';
    value = {
      mode = "0400";
      source = pkgs.writeText "${ssid}.nmconnection" ''
        [connection]
        id=${ssid}
        type=wifi

        [wifi]
        ssid=${ssid}

        [wifi-security]
        ${optionalString (opt.psk != null) ''
          key-mgmt=wpa-psk
          psk=${opt.psk}''}
      '';
    };
  };

  keyFiles = mapAttrs' createWifi config.networking.wireless.networks;
in {
  config = mkIf cfg.enable {
    environment.etc = keyFiles;

    systemd.services.NetworkManager-predefined-connections = {
      restartTriggers = mapAttrsToList (name: value: value.source) keyFiles;
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.coreutils}/bin/true";
        ExecReload = "${pkgs.networkmanager}/bin/nmcli connection reload";
      };
      reloadIfChanged = true;
      wantedBy = ["multi-user.target"];
    };
  };
}
