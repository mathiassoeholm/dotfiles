# Enable key repeating in VS Code (https://github.com/VSCodeVim/Vim#mac)
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# Link config files
ln -s ~/git/dotfiles/.ideavimrc ~/.ideavimrc
ln -s ~/git/dotfiles/nvim/ ~/.config
# After linking this
# 1. Open preferences in Karibener
# 2. Enable modification in the Complex modifications tab
ln -s ~/git/dotfiles/karabiner/custom-keys.json ~/.config/karabiner/assets/complex_modifications/custom-keys.json

# Create a directory to place VIM swap files
mkdir ~/vimswap/

#---- Setup for Nvim
# 1. Turn off Ctrl + arrow hotkeys for Mac in keyboard preferences
# 2. Map option+j and option+k to esc+j and esc+k in the iTerm2 default profile