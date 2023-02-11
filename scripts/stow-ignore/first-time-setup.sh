echo "Ask for the administrator password for the duration of this script"
sudo -v

# Move the .ssh keys from the save_me folder.
mv -r ~/Desktop/save-me/.ssh ~/.ssh/

# Make sure the ssh keys have the correct permissions
chmod 400 ~/.ssh/*

# Run ssh-agent to add the .ssh keys to your current session.
eval "$(ssh-agent -s)"

# Install Homebrew (this also installs git)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

git clone git@github.com:DeepPlateMC/dotfiles.git ~/dotfiles

# Move the .env file into the freshly cloned repo.
mv ~/Desktop/save-me/.env ~/dotfiles/

# Run the mac-setup.sh script
~/dotfiles/scripts/stow-ignore/mac-setup.sh
