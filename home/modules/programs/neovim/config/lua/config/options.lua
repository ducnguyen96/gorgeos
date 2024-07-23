-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local function run_gomodifytags(args)
	local file = vim.fn.expand("%:p") -- Get the full path of the current file
	local cmd = string.format("gomodifytags -file %s %s", file, args)
	local output = vim.fn.system(cmd)

	-- Replace buffer content with the modified output
	if vim.v.shell_error == 0 then
		local lines = vim.split(output, "\n")
		vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	else
		print("Error running gomodifytags: " .. output)
	end
end

local function go_add_tags(params)
	local args = params.args ~= "" and "-add-tags=" .. params.args or "-add-tags=json -all"
	run_gomodifytags(args)
end

local function go_remove_tags(params)
	local args = params.args ~= "" and "-remove-tags=" .. params.args or "-remove-tags=json -all"
	run_gomodifytags(args)
end

-- Define Neovim commands
vim.api.nvim_create_user_command("GoAddTags", go_add_tags, { nargs = "?" })
vim.api.nvim_create_user_command("GoRemoveTags", go_remove_tags, { nargs = "?" })
