# Dotfiles
An always work in progress repo for my dotfiles.

## Setup

#### For symlinking
- run `brew install stow`
- run `stow */` in the clone repo. This links all folders and directories

Note, if you are running into errors with .DS_STORE etc, you might want to `stow stow/` and move the stow ignore file first

For Lua formatting (like prettier for TS/JS)
- run `brew install stylua`

## Using CoC
`:CocInstall coc-tsserver coc-json coc-html coc-css`

## TODO
- At the moment I am just using https://github.com/ohmyzsh/ohmyzsh for a quick zsh setup.
