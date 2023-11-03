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

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	-- Packer
	use "wbthomason/packer.nvim"
	-- Other plugins
	use({
		"nvim-telescope/telescope.nvim", tag = "0.1.2",
		requires = { {"nvim-lua/plenary.nvim"} }
	})
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use({
		'VonHeikemen/lsp-zero.nvim',
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
		}
	})
	use({"stevearc/conform.nvim",
		config = function()
			require("conform").setup()
		end
	})
	use({"mfussenegger/nvim-dap"})
	use({"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}})

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
	require("packer").sync()
  end
end)
