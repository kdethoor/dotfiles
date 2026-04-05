-- Useful commands
vim.api.nvim_create_user_command("PackInfo"
	, function() vim.pack.update(nil, { offline = true }) end
	, {}
)

-- Plugin configuration
--local function get_plugin(name) return require("config.plugins." .. name) end
local plenary = require("config.plugins.plenary")
local telescope_fzf_native = require("config.plugins.telescope-fzf-native")
local telescope = require("config.plugins.telescope")
local treesitter = require("config.plugins.nvim-treesitter")
local catppuccin = require("config.plugins.catppuccin")
local lspconfig = require("config.plugins.lspconfig")
vim.pack.add({
	plenary
    , telescope_fzf_native
	, telescope
	, treesitter
	, catppuccin
	, lspconfig
})

