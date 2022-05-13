return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

    -- Like Prettier but styling for Lua
    use({"ckipp01/stylua-nvim"})
    require('configs.stylua')

    -- Tabs and Buffers
	use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
    require('configs.bufferline')

end)

