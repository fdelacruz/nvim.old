local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	 if server.name == "jsonls" then
	 	local jsonls_opts = require("user.lsp.settings.jsonls")
	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	 end

	 if server.name == "sumneko_lua" then
	 	local sumneko_opts = require("user.lsp.settings.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	 end

   if server.name == "rust_analyzer" then
    local rustopts = {
            tools = {
                autoSetHints = false,
                hover_with_actions = true,
                inlay_hints = {
                    show_parameter_hints = true,
                    parameter_hints_prefix = "",
                    other_hints_prefix = "",
                },
            },
            server = vim.tbl_deep_extend("force", server:get_default_options(), opts, {
                settings = {
                    ["rust-analyzer"] = {
                        completion = {
                            postfix = {
                                enable = false
                            }
                        },
                        checkOnSave = {
                            command = "clippy"
                        },
                    }
                }
            }),
        }
      require("rust-tools").setup(rustopts)
      server:attach_buffers()
  else
    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	  server:setup(opts)
  end
end)

