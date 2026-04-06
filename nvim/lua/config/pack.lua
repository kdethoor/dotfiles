-- Useful commands
vim.api.nvim_create_user_command("PackInfo"
	, function() vim.pack.update(nil, { offline = true }) end
	, {}
)

-- Plugin configuration
--local function get_plugin(name) return require("config.plugins." .. name) end
local plenary = require("config.plugins.plenary")
local telescope = require("config.plugins.telescope")
local telescope_fzf_native = require("config.plugins.telescope-fzf-native")
local treesitter = require("config.plugins.nvim-treesitter")
local catppuccin = require("config.plugins.catppuccin")
local lspconfig = require("config.plugins.lspconfig")
vim.pack.add({
	plenary.spec
	, telescope.spec
    , telescope_fzf_native.spec
	, treesitter.spec
	, catppuccin.spec
	, lspconfig.spec
})

telescope.configure_fn()
telescope_fzf_native.configure_fn()
treesitter.configure_fn()
catppuccin.configure_fn()
lspconfig.configure_fn()

