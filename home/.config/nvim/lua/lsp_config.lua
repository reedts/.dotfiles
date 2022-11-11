-- For clangd swith header vsplit/hsplit support
local function switch_source_header_splitcmd(bufnr, splitcmd)
	bufnr = require 'lspconfig'.util.validate_bufnr(bufnr)
	local params = { uri = vim.uri_from_bufnr(bufnr) }
	vim.lsp.buf_request(bufnr, 'textDocument/switchSourceHeader', params, function(err, _, result)
		if err then error(tostring(err)) end
		if not result then print("Corresponding file can’t be determined") return end
		vim.api.nvim_command(splitcmd .. ' ' .. vim.uri_to_fname(result))
	end)
end

-- Customized on_attach function for lspconfig setup
local on_attach = function(client, bufnr)
	-- Enable access to needed functions from vim api
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
end

-- Customized on_attach for cpp language-server to enable
-- custom clangd bindings
local on_attach_cpp = function(client, bufnr)
	on_attach(client, bufnr)

	-- Register keymaps for clangd
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lS', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lvS', '<cmd>ClangdSwitchSourceHeaderVSplit<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lhS', '<cmd>ClangdSwitchSourceHeaderSplit<CR>', opts)
end

vim.g.diagnostics_enabled = true
function _G.toggle_diagnostics()
	if vim.g.diagnostics_enabled then
		vim.g.diagnostics_enabled = false
		vim.diagnostic.disable()
		print('Diagnostics are disabled')
	else
		vim.g.diagnostics_enabled = true
		vim.diagnostic.enable()
		print('Diagnostics are enabled')
	end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- delay update diagnostics
    update_in_insert = false,
  }
)
vim.lsp.set_log_level(0)
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local mason = require('mason').setup()
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup({
	ensure_installed = { "clangd", "rust_analyzer" },
	automatic_installation = true
})
local null_ls = require('null-ls')
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.yapf,
		null_ls.builtins.diagnostics.flake8
	}
})

mason_lspconfig.setup_handlers({
	function(server_name) -- (default handler)
		local default_opts = {}
		lspconfig[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilitites
		})
	end,
	["pylsp"] = function()
		lspconfig.pylsp.setup({
			on_attach = on_attach,
			capabilitites = capabilitites,
			settings = {
				pylsp = {
					plugins = {
						yapf = {
							enabled = true
						},
						autopep8 = {
							enabled = false
						},
						pydocstyle = {
							enabled = false
						}
					}
				}
			}
		})
	end,
	["clangd"] = function()
		lspconfig.clangd.setup({
			on_attach = on_attach_cpp,
			capabilitites = capabilitites,
			commands = {
				ClangdSwitchSourceHeader = {
					function() switch_source_header_splitcmd(0, "edit") end;
					description = "Open source/header in current buffer";
				},
				ClangdSwitchSourceHeaderVSplit = {
					function() switch_source_header_splitcmd(0, "vsplit") end;
					description = "Open source/header in a new vsplit";
				},
				ClangdSwitchSourceHeaderSplit = {
					function() switch_source_header_splitcmd(0, "split") end;
					description = "Open source/header in a new split";
				}
			}
		})
	end,
})
