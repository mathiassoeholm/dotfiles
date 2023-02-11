echo "Ask for the administrator password for the duration of this script"
sudo -v

# Load the .env file and export all the environment variables
export $(grep -v '^#' ~/dotfiles/.env | xargs)

# Set the name and email inside the global git config.
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# Set the strategy to reconcile divergent branches for Git to rebase.
git config --global pull.rebase true

# Automatically hide and show the Dock
# Disable the dock animation, to make it show/hide instantly
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -int 0;
defaults write com.apple.dock tilesize -int $DOCK_ICON_SIZE;
killall Dock

# Automatically hide the menu bar.
defaults write NSGlobalDomain _HIHideMenuBar -bool true

if [ $MOUSE_ACCELERATION == "true" ]
then
	echo "Enabled mouse acceleration"
	defaults write .GlobalPreferences com.apple.mouse.scaling 1
else 
	echo "Disabled mouse acceleration"
	defaults write .GlobalPreferences com.apple.mouse.scaling -1
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
brew update

# Install stow, which is our symlinker.
brew install stow

# Symlink the .stow-ignore.
# Symlink all directories inside the dotfiles directory.
cd ~/dotfiles && stow stow/ && stow */ && cd -

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended
source ~/.zshrc

# Install all the brew packages
brew install neovim
brew install wget
brew install ripgrep

brew install vifm

brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
brew install git
brew install gitui

brew install nvm
brew install --cask amethyst
brew install --cask kitty
brew install --cask karabiner-elements
brew install --cask brave-browser

# Install the latest LTS version of node
nvm install --lts

# Install global NPM packages that are used by the dotfiles
npm install -g yarn
