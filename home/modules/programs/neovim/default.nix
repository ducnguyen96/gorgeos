{
  config,
  pkgs,
  ...
}: let
  nvimFolder = "${config.home.homeDirectory}/.config/nvim";
  configFolder = "${nvimFolder}/lua/config";
  pluginsFolder = "${nvimFolder}/lua/plugins";

  enableLanguage = lang:
    if config.dev.${lang}.enable
    then "{ import = \"lazyvim.plugins.extras.lang.${lang}\" },"
    else "";

  enableGo = enableLanguage "go";
  enableNix = enableLanguage "nix";
  enableRust = enableLanguage "rust";
  enableSql = enableLanguage "sql";
  enableTailwind = enableLanguage "tailwind";
  enableTerraform = enableLanguage "terraform";
  enableTypescript = enableLanguage "typescript";
  enableVue = enableLanguage "vue";
  enableClangd = enableLanguage "clangd";
  enablePython = enableLanguage "python";
  enablePhp = enableLanguage "php";

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
  # NOTE: enable nixos's nix-ld to be able to use mason packages.
  # add below config to your nixos config module(eg: hosts/profiles/rtx2070/default.nix)
  # programs.nix-ld.enable = true;

  home.packages = with pkgs; [
    # dependencies
    ripgrep
    fd
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.file."${configFolder}/lazy.lua" = {
    text = ''
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not (vim.uv or vim.loop).fs_stat(lazypath) then
      	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
      	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
      	if vim.v.shell_error ~= 0 then
      		vim.api.nvim_echo({
      			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      			{ out, "WarningMsg" },
      			{ "\nPress any key to exit..." },
      		}, true, {})
      		vim.fn.getchar()
      		os.exit(1)
      	end
      end
      vim.opt.rtp:prepend(lazypath)

      require("lazy").setup({
      	spec = {
      		-- add LazyVim and import its plugins
      		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
          { import = "lazyvim.plugins.extras.coding.mini-surround" },
          { import = "lazyvim.plugins.extras.formatting.prettier" },
          { import = "lazyvim.plugins.extras.linting.eslint" },
          { import = "lazyvim.plugins.extras.util.project" },
          { import = "lazyvim.plugins.extras.ai.copilot" },
          { import = "lazyvim.plugins.extras.ai.copilot-chat" },

          ${enableGo}
          ${enableNix}
          ${enableRust}
          ${enableSql}
          ${enableTailwind}
          ${enableTerraform}
          ${enableTypescript}
          ${enableVue}
          ${enableClangd}
          ${enablePython}
          ${enablePhp}

      		-- import/override with your plugins
      		{ import = "plugins" },
      		{ import = "nix-generated-plugins" },
      	},
      	defaults = {
      		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
      		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
      		lazy = false,
      		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
      		-- have outdated releases, which may break your Neovim install.
      		version = false, -- always use the latest git commit
      		-- version = "*", -- try installing the latest stable version for plugins that support semver
      	},
      	install = { colorscheme = { "tokyonight", "habamax" } },
      	checker = {
      		enabled = true, -- check for plugin updates periodically
      		notify = false, -- notify on update
      	}, -- automatically check for plugin updates
      	performance = {
      		rtp = {
      			-- disable some rtp plugins
      			disabled_plugins = {
      				"gzip",
      				-- "matchit",
      				-- "matchparen",
      				-- "netrwPlugin",
      				"tarPlugin",
      				"tohtml",
      				"tutor",
      				"zipPlugin",
      			},
      		},
      	},
      })
    '';
  };

  home.file."${nvimFolder}/lua/nix-generated-plugins/lspconfig.lua" = {
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

  home.file."${nvimFolder}/init.lua".source = ./config/init.lua;

  home.file."${configFolder}/autocmds.lua".source = ./config/lua/config/autocmds.lua;
  home.file."${configFolder}/keymaps.lua".source = ./config/lua/config/keymaps.lua;
  home.file."${configFolder}/options.lua".source = ./config/lua/config/options.lua;

  home.file."${pluginsFolder}".source = ./config/lua/plugins;
}
