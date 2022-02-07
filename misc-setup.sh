# Enable key repeating in VS Code (https://github.com/VSCodeVim/Vim#mac)
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# Link config files
ln -s ~/git/dotfiles/.ideavimrc ~/.ideavimrc
ln -s ~/git/dotfiles/vim/init.vim ~/.config/nvim/init.vim
ln -s ~/git/dotfiles/vim/lua/ ~/.config/nvim

# Install Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Create a directory to place VIM swap files
mkdir ~/vimswap/
