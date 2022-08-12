local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
                                  install_path}
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {
                border = "rounded"
            }
        end
    }
}

local function is_vscode()
    return vim.g.vscode
end

local function is_not_vscode()
    return not vim.g.vscode
end

print(is_not_vscode())

-- Install your plugins here
return packer.startup(function(use)
    function nvimPlugin(name)
        use {
            name,
            cond = is_not_vscode
        }
    end
    function vscodePlugin(name)
        use {
            name,
            cond = is_vscode
        }
    end

    use "wbthomason/packer.nvim" -- Have packer manage itsel

    vscodePlugin "asvetliakov/vim-easymotion"

    -- Many plugins rely on these two plugins, so they are just here if needed
    nvimPlugin "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    nvimPlugin "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

    -- Colorschemes 
    nvimPlugin "lunarvim/darkplus.nvim"

    -- cmp plugins
    nvimPlugin "hrsh7th/nvim-cmp" -- The completion plugin
    nvimPlugin "hrsh7th/cmp-buffer" -- buffer completions
    nvimPlugin "hrsh7th/cmp-path" -- path completions
    nvimPlugin "hrsh7th/cmp-cmdline" -- cmdline completions
    nvimPlugin "saadparwaiz1/cmp_luasnip" -- snippet completions

    -- snippets
    nvimPlugin "L3MON4D3/LuaSnip" -- snippet engine
    nvimPlugin "rafamadriz/friendly-snippets" -- a bunch of snippets to use use "lunarvim/darkplus.nvim"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
