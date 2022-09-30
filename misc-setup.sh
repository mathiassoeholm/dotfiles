# Enable key repeating in VS Code (https://github.com/VSCodeVim/Vim#mac)
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# Link config files
ln -s ~/git/dotfiles/.ideavimrc ~/.ideavimrc
ln -s ~/git/dotfiles/nvim/ ~/.config
ln -s ~/git/dotfiles/gitui/ ~/.config
ln -s ~/git/dotfiles/.zshrc ~/.zshrc
ln -s ~/git/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/git/dotfiles/code/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/git/dotfiles/code/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

# Afterwards rules needs to be enabled in the Karabiner UI
ln -s ~/git/dotfiles/karabiner.json ~/.config/karabiner/assets/complex_modifications/karabiner.json

# After linking this
# 1. Open preferences in Karibener
# 2. Enable modification in the Complex modifications tab
ln -s ~/git/dotfiles/karabiner/custom-keys.json ~/.config/karabiner/assets/complex_modifications/custom-keys.json

# Create a directory to place VIM swap files
mkdir ~/vimswap/

#---- Setup for Nvim
# 1. Turn off Ctrl + arrow hotkeys for Mac in keyboard preferences
# 2. Install the Hack nerd font
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
Change font to Hack in iTerm2 (Profiles -> Text -> Font)