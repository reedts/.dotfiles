local actions = require'telescope.actions'

-- Global setup and configuration
require'telescope'.setup {
	defaults = {
		mappings = {
			i = {
				["<C-q>"] = actions.send_to_qflist,
				["<C-s>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical
			},
			n = {
				["<C-s>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical
			}
		},
		prompt_prefix = " ",
		selection_caret = " "
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorger = true,
		}
	}
}

require'telescope'.load_extension('fzy_native')

local M = {}
M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "homesick",
		cwd = "$HOME/.homesick/repos/.dotfiles/home",
		hidden = true
	})
end


M.search_config= function()
	require("telescope.builtin").find_files({
		prompt_title = "config",
		cwd = "$HOME/.config",
		hidden = true
	})
end

return M
