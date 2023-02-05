echo "Ask for the administrator password for the duration of this script"
sudo -v

# Load the .env file and export all the environment variables
export $(grep -v '^#' .env | xargs)

# Disable the dock animation, to make it show/hide instantly
defaults write com.apple.dock autohide-time-modifier -int 0;

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

killall Dock

if [ $MOUSE_ACCELERATION = "true" ]
then
	echo "Enabled mouse acceleration"
	defaults write .GlobalPreferences com.apple.mouse.scaling 1
else 
	echo "Disabled mouse acceleration"
	defaults write .GlobalPreferences com.apple.mouse.scaling -1
fi

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install the latest LTS version of node
nvm install --lts

# Install global NPM packages that are used by the dotfiles
npm install -g yarn
yarn global add @aivenio/tsc-output-parser
