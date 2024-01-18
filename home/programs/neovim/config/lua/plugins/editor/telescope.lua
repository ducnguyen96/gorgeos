local Util = require("lazyvim.util")

return {
	"nvim-telescope/telescope.nvim",
	keys = {
		{
			"<leader>gb",
			function()
				require("telescope.builtin").git_branches()
			end,
			desc = "List git branches",
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Live grep",
		},
	},
	opts = function(_, opts)
		if not Util.has("flash.nvim") then
			return
		end
		local function flash(prompt_bufnr)
			require("flash").jump({
				pattern = "^",
				label = { after = { 0, 0 } },
				search = {
					mode = "search",
					exclude = {
						function(win)
							return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
						end,
					},
				},
				action = function(match)
					local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
					picker:set_selection(match.pos[1] - 1)
				end,
			})
		end
		opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
			mappings = { n = { s = flash }, i = { ["<c-s>"] = flash } },
		})
	end,
}
