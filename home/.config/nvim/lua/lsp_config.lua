-- For clangd swith header vsplit/hsplit support
local function switch_source_header_splitcmd(bufnr, splitcmd)
    bufnr = require'lspconfig'.util.validate_bufnr(bufnr)
    local params = { uri = vim.uri_from_bufnr(bufnr) }
    vim.lsp.buf_request(bufnr, 'textDocument/switchSourceHeader', params, function(err, _, result)
        if err then error(tostring(err)) end
        if not result then print ("Corresponding file can’t be determined") return end
        vim.api.nvim_command(splitcmd..' '..vim.uri_to_fname(result))
    end)
end

-- Customized on_attach function for lspconfig setup
local on_attach = function(client, bufnr)
	-- Enable access to needed functions from vim api
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable highlighting for text groups
    if client.resolved_capabilities.document_highlight then
    	require 'illuminate'.on_attach(client)
	end
end

-- Customized on_attach for cpp language-server to enable
-- custom clangd bindings
local on_attach_cpp = function(client, bufnr)
	on_attach(client, bufnr)

	-- Register keymaps for clangd
	local opts = { noremap=true, silent=true}
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

local lspconfig = require'lspconfig'
local cmp = require'cmp'
local lsp_installer = require'nvim-lsp-installer'
lsp_installer.setup({automatic_installation = true})

for _, server in pairs(lsp_installer:get_installed_servers()) do
	local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
	local default_opts = {on_attach = on_attach, capabilities = capabilitites}

	local server_opts = {
		["pylsp"] = function()
            default_opts.settings = {
                pylsp = {
                    plugins = {
                        yapf = {
                            enabled = true
                        },
                        autopep8 = {
                            enabled = false
                        },
	                    pydocstyle = {
                            enabled = true
                        }
                    }
                }
            }
            return default_opts
        end,
		["clangd"] = function()
			default_opts.on_attach = on_attach_cpp
            default_opts.commands = {
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
			return default_opts
		end,
	}
	
	lspconfig[server.name].setup(server_opts[server.name] and server_opts[server.name]() or default_opts)
end
