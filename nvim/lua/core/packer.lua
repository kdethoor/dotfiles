local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
	vim.cmd [[packadd packer.nvim]]
	return true
  end
  return false
end

local is_only_enabled_outside_code = function()
	return vim.g.vscode == nil
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	-- Packer
	use({"wbthomason/packer.nvim"})
	-- Other plugins
	use({
		"nvim-telescope/telescope.nvim", tag = "0.1.2",
		cond = is_only_enabled_outside_code(),
		requires = { {"nvim-lua/plenary.nvim"} },
	})
	use({
		"catppuccin/nvim",
		cond = is_only_enabled_outside_code(),
		as = "catppuccin",
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		cond = is_only_enabled_outside_code(),
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use({
		"mbbill/undotree",
		cond = is_only_enabled_outside_code(),
	})
	use({
		"tpope/vim-fugitive",
		cond = is_only_enabled_outside_code(),
	})
	use({
		'VonHeikemen/lsp-zero.nvim',
		cond = is_only_enabled_outside_code(),
		branch = 'v3.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		},
	})
	use({"stevearc/conform.nvim",
		cond = is_only_enabled_outside_code(),
		config = function()
			require("conform").setup()
		end
	})
	use({
		"mfussenegger/nvim-dap",
		cond = is_only_enabled_outside_code(),
	})
	use({
		"rcarriga/nvim-dap-ui",
		cond = is_only_enabled_outside_code(),
		requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
	})

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
	require("packer").sync()
  end
end)
