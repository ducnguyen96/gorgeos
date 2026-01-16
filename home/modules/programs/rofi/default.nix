{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.lib.formats.rasi) mkLiteral;
in {
  programs.rofi = {
    enable = true;
    plugins = [pkgs.rofi-calc];
    theme = {
      "@theme" = lib.mkForce "catppuccin-${config.catppuccin.flavor}";
      "@import" = "catppuccin-${config.catppuccin.flavor}";

      /*
      1. Global / Element Reset
      */
      "element-text, element-icon, mode-switcher" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      /*
      2. Window Settings (Opacity 0.85)
      */
      "window" = {
        height = mkLiteral "360px";
        border = mkLiteral "1px";
        border-color = mkLiteral "@mauve";
        border-radius = mkLiteral "12px";
        background-color = mkLiteral "#1e1e2ed9";
      };

      "inputbar" = {
        children = ["prompt" "entry"];
        background-color = mkLiteral "@base";
        border-radius = mkLiteral "5px";
        padding = mkLiteral "2px";
        margin = mkLiteral "0px 10px 0px 0px";
      };

      "prompt, message" = {
        background-color = mkLiteral "@mauve";
        padding = mkLiteral "6px";
        text-color = mkLiteral "@crust";
        border-radius = mkLiteral "3px";
      };

      "prompt" = {
        margin = mkLiteral "20px 0px 0px 20px";
      };

      "message" = {
        margin = mkLiteral "10px 20px 0px 20px";
      };

      /*
      3. Layout & Spacing
      */

      "entry" = {
        padding = mkLiteral "6px";
        margin = mkLiteral "20px 0px 0px 10px";
        text-color = mkLiteral "@text";
        placeholder = "Search...";
        background-color = mkLiteral "@base";
      };

      "listview" = {
        border = mkLiteral "0px 0px 0px";
        padding = mkLiteral "6px 0px 0px";
        margin = mkLiteral "10px 0px 0px 20px";
        columns = 2;
        lines = 5;
        background-color = mkLiteral "@base";
      };

      "element" = {
        padding = mkLiteral "5px";
        text-color = mkLiteral "@text";
        background-color = mkLiteral "@base";
      };

      "element-icon" = {
        size = mkLiteral "25px";
      };

      "element selected" = {
        text-color = mkLiteral "@mauve";
        border-radius = mkLiteral "5px";
        background-color = mkLiteral "transparent";
      };

      /*
      4. Transparent Containers
      */
      "mainbox, inputbar, listview, element, textbox" = {
        background-color = mkLiteral "transparent";
      };

      /*
      Support for the ":" colon if needed
      */
      "textbox-prompt-colon" = {
        expand = false;
        str = ":";
      };
    };
  };
}
