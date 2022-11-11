local lualine = require('lualine')
local theme = 'tomorrow_night_eighties'
local colors = require('lualine.themes.colors').colors

local function lsp_clients()
	local clients = vim.lsp.get_active_clients({ bufnr = 0 })
	local names = {}

	for i, client in ipairs(clients) do
		names[i] = client.name
	end

	return table.concat(names, ',')
end

lualine.setup({
	options = {
		theme = theme,
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_a = {
			{
				'mode',
				separator = { left = '', right = '' }
			}
		},
		lualine_b = {
			{
				'branch',
				icons_enabled = true,
				icon = { '', align = 'left' },
				color = { fg = colors.purple },
				separator = { left = '', right = '' },
			}
		},
		lualine_c = {
			{
				'filename',
				file_status = true,
				newfile_status = true,

				symbols = {
					modified = '[*]',
					readonly = '',
					unnamed = '[None]',
					newfile = '',
				}
			},
		},
		lualine_x = {
			{
				'lsp_progress',
				colors = {
					percentage      = colors.lightgray,
					title           = colors.lightgray,
					message         = colors.lightgray,
					lsp_client_name = colors.blue,
					use             = true,
				},
				separators = {
					component = ' ',
					progress = ' | ',
					message = { pre = '(', post = ')' },
					percentage = { pre = '', post = '%% ' },
					title = { pre = '', post = ': ' },
					lsp_client_name = { pre = '[', post = ']' },
				},
				display_components = { 'lsp_client_name', { 'title', 'percentage' } },
				timer = { progress_enddelay = 500, spinner = 100, lsp_client_name_enddelay = 1000 },
			}
		},
		lualine_y = {
			{
				'diff',
				symbols = { added = ' ', modified = ' ', removed = ' ' },
			},
			'encoding',
			'filetype',
			{
				lsp_clients,
				icon = { '勞', align = 'left', color = { fg = colors.orange } }
			}
		},
		lualine_z = {
			{
				'location',
				separator = { right = '', left = '' },
				icons_enables = true,
				icon = { '', align = 'right' },
				fmt = function(str)
					return str .. ' / ' .. vim.api.nvim_buf_line_count(0)
				end
			}
		}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	extensions = { 'fugitive', 'nvim-tree' }
})
