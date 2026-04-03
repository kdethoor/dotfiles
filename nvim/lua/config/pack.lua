-- Useful commands
vim.api.nvim_create_user_command("PackInfo"
	, function() vim.pack.update(nil, { offline = true }) end
	, {}
)

-- Plugin configuration
local plenary = require("config.plugins.plenary")
local telescope = require("config.plugins.telescope")
local treesitter = require("config.plugins.nvim-treesitter")
local catppuccin = require("config.plugins.catppuccin")
vim.pack.add({
	plenary
	, telescope
	, treesitter
	, catppuccin
})

