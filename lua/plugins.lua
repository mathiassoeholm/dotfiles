return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
    require('configs.bufferline')

end)

