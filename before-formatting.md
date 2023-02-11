# Things to do before formatting your system

- Make sure you have backed up your browser settings.
  - For Brave, you can use their Syncing.
- Save the following files on an USB stick
  - Your private and public SSH keys used for things like Github.
    - `mkdir -p ~/save-me/.ssh/ && cp ~/.ssh/id* ~/save-me/.ssh/`
  - The .env file from this repository.
    - `mkdir -p ~/save-me/dotfiles && cp ~/dotfiles/.env ~/save-me/dotfiles/`
  - Save any configuration files from any git repositories you have saved locally. These usually exist as `.env` files.
  - Save any personal files you have on your PC. If you have any, you should probably get rid of the habit of storing important files on your computer.
  - Push all local branches in all of your git repositories.
    - `git push --all origin`
  - Copy the installation.md file to the USB. `cp ~/dotfiles/installation.md ~/save-me/`
  - Copy the `mac-setup.sh` script.
	- `cp ~/dotfiles/scripts/stow-ignore/mac-setup.sh ~/save-me/`
  - Move the `~/save-me/` to your USB stick.

## To start formatting
- Follow the guide [here](https://support.apple.com/guide/mac-help/erase-your-mac-mchl7676b710/13.0/mac/13.0)
