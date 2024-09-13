#!/bin/zsh

echo "Ask for the administrator password for the duration of this script"
sudo -v

# Load the .env file and export all the environment variables
export $(grep -v '^#' ~/dotfiles/.env | xargs)

# Set the name and email inside the global git config.
git config --global user.name "$DOTFILES_GIT_NAME"
git config --global user.email "$DOTFILES_GIT_EMAIL"

# Set the strategy to reconcile divergent branches for Git to rebase.
git config --global pull.rebase true

# Allow git pull on a dirty working tree.
git config --global rebase.autoStash true

# Automatically hide and show the Dock
# Disable the dock animation, to make it show/hide instantly
defaults write com.apple.dock autohide -bool true
defaults write com.apple.Dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -int 0;
defaults write com.apple.dock tilesize -int $DOTFILES_DOCK_ICON_SIZE;
killall Dock

# Automatically hide the menu bar.
defaults write NSGlobalDomain _HIHideMenuBar -bool true

if [ $DOTFILES_MOUSE_ACCELERATION == "true" ]
then
	echo "Enabled mouse acceleration"
	defaults write .GlobalPreferences com.apple.mouse.scaling 1
else 
	echo "Disabled mouse acceleration"
	defaults write .GlobalPreferences com.apple.mouse.scaling -1
fi

if [ $DOTFILES_FAST_KEY_REPEAT == "true" ]
then
	echo "Setting fast key repeat rate"
	defaults write -g InitialKeyRepeat -int 15
	defaults write -g KeyRepeat -int 2
fi

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/agkozak/zsh-z ~/.oh-my-zsh/custom/plugins/zsh-z

eval "$(/opt/homebrew/bin/brew shellenv)"
brew update

# Install stow, which is our symlinker.
brew install stow

# Symlink the .stow-ignore.
# Symlink all directories inside the dotfiles directory.
cd ~/dotfiles && stow stow/ && stow */ && cd -

# Check if .oh-my-zsh directory exists
if [ -d "$HOME/.oh-my-zsh" ]; then
  # Update Oh My Zsh if the directory exists
  "$ZSH/tools/upgrade.sh"
else
  # Install Oh My Zsh if the directory does not exist
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended
  source ~/.zshrc
fi

# Install all the brew packages
brew install wget
brew install ripgrep
brew install git
brew install git-lfs
brew install remotemobprogramming/brew/mob
brew install pre-commit
brew install java
brew install nvm
brew install go
brew install --cask amethyst
brew install --cask kitty
brew install --cask karabiner-elements
brew install --cask brave-browser
brew install --cask discord
brew install --cask docker
brew install --cask spotify
brew install --cask raycast
brew install --cask nikitabobko/tap/aerospace

# Install the latest LTS version of node
nvm install --lts

# Install global NPM packages that are used by the dotfiles
npm install -g yarn

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
