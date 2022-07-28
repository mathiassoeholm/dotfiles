# Enable key repeating in VS Code (https://github.com/VSCodeVim/Vim#mac)
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# Link config files
ln -s ~/git/dotfiles/.ideavimrc ~/.ideavimrc
ln -s ~/git/dotfiles/vim/init.lua ~/.config/nvim/init.lua
ln -s ~/git/dotfiles/vim/lua/ ~/.config/nvim
# After linking this
# 1. Open preferences in Karibener
# 2. Enable modification in the Complex modifications tab
ln -s ~/git/dotfiles/karabiner/custom-keys.json ~/.config/karabiner/assets/complex_modifications/custom-keys.json

# Install Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Create a directory to place VIM swap files
mkdir ~/vimswap/
