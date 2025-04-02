{config, ...}: let
  nvimFolder = "${config.home.homeDirectory}/.config/nvim";
  pluginsFolder = "${nvimFolder}/lua/plugins";

  disableMasonClangd =
    if config.dev.clangd.useMasonLSP
    then ""
    else "clangd = { mason = false },";

  disableMasonGo =
    if config.dev.go.useMasonLSP
    then ""
    else "gopls = { mason = false },";

  disableMasonLua =
    if config.dev.lua.useMasonLSP
    then ""
    else "lua_ls = { mason = false },";

  disableMasonNix =
    if config.dev.nix.useMasonLSP
    then ""
    else "nil_ls = { mason = false },";

  disableMasonPhp =
    if config.dev.php.useMasonLSP
    then ""
    else "phpactor = { mason = false }, intelephense = { mason = false },";

  disableMasonPython =
    if config.dev.python.useMasonLSP
    then ""
    else "ruff = { mason = false }, ruff_lsp = { mason = false },";

  disableMasonRust =
    if config.dev.rust.useMasonLSP
    then ""
    else "bacon_ls = { mason = false }, rust_analyzer = { mason = false },";

  disableMasonTypescript =
    if config.dev.typescript.useMasonLSP
    then ""
    else "vtsls = { mason = false },";
in {
  home.file."${pluginsFolder}/lspconfig.lua" = {
    text = ''
      return {
      	{
      		"neovim/nvim-lspconfig",
      		opts = {
      			servers = {
              ${disableMasonClangd}
              ${disableMasonGo}
              ${disableMasonLua}
              ${disableMasonNix}
              ${disableMasonPhp}
              ${disableMasonPython}
              ${disableMasonRust}
              ${disableMasonTypescript}
      			},
      			inlay_hints = {
      				enabled = false,
      			},
      		},
      	},
      }
    '';
  };
}
