{pkgs}: let
  fetchCryptoPrice = symbol: icon: {
    interval = 300;

    format = "{}";

    return-type = "plain";

    exec = pkgs.writeShellScript "crypto-${symbol}" ''
      ${pkgs.curl}/bin/curl -Lsf --max-time 5 \
        "https://api.binance.com/api/v3/ticker/price?symbol=${symbol}" \
        | ${pkgs.jq}/bin/jq -r '"${icon} " + (.price | tonumber | floor | tostring)' \
        || echo "${icon} N/A"
    '';

    tooltip = false;
  };
in {
  "custom/btc" = fetchCryptoPrice "BTCUSDT" "󰠓";

  "custom/eth" = fetchCryptoPrice "ETHUSDT" "󰡪";

  "custom/bnb" = fetchCryptoPrice "BNBUSDT" "❖";

  "group/crypto" = {
    orientation = "horizontal";

    modules = [
      "custom/btc"
      "custom/eth"
      "custom/bnb"
    ];
  };
}
