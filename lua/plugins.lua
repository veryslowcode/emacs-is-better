-- Function to ensure that Packer.nvim
-- is available. If Packer.nvim is not
-- installed, this function will
-- retrieve it from Github.
local require_packer = function()
	local api = vim.fn
	local path = api.stdpath("data").."/site/pack/packer/start/packer.nvim"

	if api.empty(api.glob(path)) > 0 then
		api.system({ "git", "clone", "--depth", "1",
		  "https://github.com/wbthomason/packer.nvim",
	           path})

		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local bootstrap = require_packer()

-- All plugins required for this configuration
return require("packer").startup(function(use)
	use "wbthomason/packer.nvim"
	-- Plugins
	-- Telescope for fuzzy find
	use {"nvim-telescope/telescope.nvim",
	requires = {{"nvim-lua/plenary.nvim"}}}
	-- Theme
    use { "catppuccin/nvim", as = "catppuccin" }
    -- Treesitter for syntax highlighting
    use "nvim-treesitter/nvim-treesitter"
    -- Mason for LSP integration
    use "neovim/nvim-lspconfig"
    use {"williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"}
    -- Debugging
    use "mfussenegger/nvim-dap"
    -- Code completion
    use {"hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp"}
    -- Code Comments
    use "numToStr/Comment.nvim"
	-- Automatically sync plugins
	if bootstrap then
		require("packer").sync()
	end
end)
