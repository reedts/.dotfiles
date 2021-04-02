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
		}
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorger = true,
		}
	}
}

require'telescope'.load_extension('fzy_native')
