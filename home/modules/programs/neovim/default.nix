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

  enableNix = enableLanguage "nix";
  enableTypescript = enableLanguage "typescript";
  enableRust = enableLanguage "rust";
in {
  # NOTE: enable nixos's nix-ld to be able to use mason packages.
  # add below config to your nixos config module(eg: hosts/profiles/rtx2070/default.nix)
  # programs.nix-ld.enable = true;

  home.packages = with pkgs; [
    # dependencies
    gcc
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
      		{ import = "lazyvim.plugins.extras.util.project" },

          ${enableNix}
          ${enableTypescript}
          ${enableRust}
      		-- import/override with your plugins
      		{ import = "plugins" },
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

  home.file."${nvimFolder}/init.lua".source = ./config/init.lua;

  home.file."${configFolder}/autocmds.lua".source = ./config/lua/config/autocmds.lua;
  home.file."${configFolder}/keymaps.lua".source = ./config/lua/config/keymaps.lua;
  home.file."${configFolder}/options.lua".source = ./config/lua/config/options.lua;

  home.file."${pluginsFolder}".source = ./config/lua/plugins;
}
