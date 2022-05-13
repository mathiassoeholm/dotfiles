return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
    
    -- For running different language servers
    use 'neovim/nvim-lspconfig'
    require('configs.lspconfig')

    -- For better highlighting and file knowlage
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    require('configs.treesitter')

    -- Like Prettier but styling for Lua
    use({"ckipp01/stylua-nvim"})
    require('configs.stylua')

    -- Themes
    use { "ellisonleao/gruvbox.nvim" }

    -- comment out lines of code
    use { "tpope/vim-commentary" }
    use { "tpope/vim-fugitive" } 
    require('configs.fugitive')

    -- Tabs and Buffers
	use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
    require('configs.bufferline')

end)
 
