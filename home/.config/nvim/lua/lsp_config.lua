local navic = require('nvim-navic')
-- Customized on_attach function for lspconfig setup
local on_attach = function(client, bufnr)
	-- Enable access to needed functions from vim api
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	navic.attach(client, bufnr)
end

-- Customized on_attach for cpp language-server to enable
-- custom clangd bindings
local on_attach_cpp = function(client, bufnr)
	on_attach(client, bufnr)

	-- Register keymaps for clangd
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lS', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
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
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.cmake_format,
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
		})
	end,
})
