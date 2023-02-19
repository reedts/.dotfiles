local lualine = require('lualine')
local navic = require('nvim-navic')
navic.setup({
	separator = "  "
})
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

local function mamba_env()
	local env_name = os.getenv("CONDA_DEFAULT_ENV")
	if env_name ~= nil then
		return env_name
	else
		return ''
	end
end


local function spell()
  if vim.wo.spell == true then -- Note that 'spell' is a window option, so: wo
    return '[' .. vim.bo.spelllang .. ']'
  end
  return ''
end

lualine.setup({
	options = {
		theme = theme,
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			'Trouble',
			winbar = {
				'NvimTree'
			}
		}
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
				spell,
				separator = { left = '', right = '' },
			},
			{
				'branch',
				icons_enabled = true,
				icon = { '', align = 'left' },
				color = { fg = colors.purple },
				separator = { left = '', right = '' },
			},
			{
				'diff',
				symbols = { added = ' ', modified = ' ', removed = ' ' },
				separator = { left = '', right = '' },
			},
		},
		lualine_c = {
			{
				'filename',
				file_status = true,
				newfile_status = true,
				path = 1,

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
			},
		},
		lualine_y = {
			'encoding',
			'filetype',
			{
				mamba_env,
				icon = { '🅒 ', align = 'left', color = { fg = colors.green } }
			},
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
					return str .. ' 﫦' .. vim.api.nvim_buf_line_count(0)
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
	tabline = {
		lualine_a = {
			{
				'buffers',
				mode = 2,
				filetype_names = {
					TelescopePrompt = 'Telescope',
					Trouble = 'Trouble',
				},
				separator = '│',
				buffers_color = {
					active = { fg = colors.green, bg = colors.gray },
					inactive = { fg = colors.white, bg = colors.line },
				},
			}

		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {
			{
				navic.get_location,
				cond = navic.is_available,
				separator = { right = '', left = '' },
				color = { gui = 'None' },
			}
		}
	},
	extensions = { 'fugitive', 'nvim-tree' }
})
