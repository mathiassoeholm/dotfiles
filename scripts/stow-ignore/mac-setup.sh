# Load the .env file and export all the environment variables
export $(grep -v '^#' .env | xargs)

# Disable the dock animation, to make it show/hide instantly
defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock

if [ $MOUSE_ACCELERATION = "true" ]
then
	echo "Enabled mouse acceleration"
	defaults write .GlobalPreferences com.apple.mouse.scaling 1
else 
	echo "Disabled mouse acceleration"
	defaults write .GlobalPreferences com.apple.mouse.scaling -1
fi
