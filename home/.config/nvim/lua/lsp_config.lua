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
end

-- Dynamically load lspservers after installation
local function setup_servers()

	-- Register servers automatically installed with lspinstall
	require'lspinstall'.setup()
	local servers = require'lspinstall'.installed_servers()
	for _, server in pairs(servers) do
		if server == "cpp" then
			require'lspconfig'[server].setup({on_attach = on_attach,
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
		else
			-- Use our on_attach function
			require'lspconfig'[server].setup({on_attach = on_attach})
		end
	end

	-- Servers manually installed are registered here
	require'lspconfig'.pyls.setup({on_attach = on_attach})
end

setup_servers()

local lspconfig = require'lspconfig'

require'lspinstall'.post_install_hook = function ()
	setup_servers()
	vim.cmd("bufdo e")
end
