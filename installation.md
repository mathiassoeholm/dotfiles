## Running first time setup

- Copy the `save-me` folder from the USB to your desktop.
  - `cp -r ~/Volumes/$VOLUME/save-me ~/Desktop/save-me/`
- Run the `scripts/stow-ignore/first-time-setup.sh`

## Things you have to do manually

### Amethyst

- Set Amethyst to automatically start when the mac starts.
  - You do this by clicking the Amethyst icon in the menu bar.

### Keyboard

- Open all your mac spaces and setup the keybindings from System preferences.
- Change repeat delay and interval to the smallest values
- Enable complex modification in Karabiner Elements, then restart

### Other Mac settings

- Change Spaces slide animation to fade: System settings -> Search "Reduce motion" -> Enable Reduce motion

### Nvim

- open `nvim` and run `:PackerSync`
- open `nvim` and run `:Mason`

Install these packages manually with `Mason` in `nvim`:

- `rust-analyzer`
- `prettierd`
- `eslint_d`
- `gofumpt`
- `stylua`

### Github Copilot

- Run the `CopilotAuth` command in `nvim`

### Other applications

- [Height](https://height.app/download)
