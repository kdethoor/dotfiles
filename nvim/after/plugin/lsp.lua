local success, lsp = pcall(require, "lsp-zero")

if not success then
	return
end

-- Language servers

--- LSP config
local lspconfig = require("lspconfig")

--- Local overrides
local local_override = nil
success, local_override = pcall(require, "core_override")
if not success then
	local_override = nil
end

--- LSP-specific remaps
lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "<leader>[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "<leader>]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

--- LSP installation (assumes mason was installed with lsp-zero
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"pyright", -- pyright requires npm
		"clangd",
		"omnisharp" -- omnisharp requires dotnet
	},
	handlers = {
		lsp.default_setup,
		lua_ls = function()
			local lua_opts = lsp.nvim_lua_ls()
			lspconfig.lua_ls.setup(lua_opts)
		end,
		omnisharp = function()
			local patterns = { "*.csproj", "*.sln" }
			if local_override then
				local n = #local_override.lsp.omnisharp_root_patterns
				for i = 1, n do
					patterns[i] = local_override.lsp.omnisharp_root_patterns[i]
				end
			end
			lspconfig.omnisharp.setup {
				root_dir = lspconfig.util.root_pattern(patterns)
			}
		end
	}
})

-- Autocompletion (assumes cmp was installed with lsp-zero)
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})
cmp.setup({ mapping = cmp_mappings })
