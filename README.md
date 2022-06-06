# Dotfiles
An always work in progress repo for my dotfiles.

## Setup

#### For Symlinking
- run `brew install stow`
- run `stow stow/` to setup stow ignore before anything else, to make sure we ignore .DS_STORE etc.
- run `stow */` then symlink everything else

#### For ZSH
- follow the instructions on https://github.com/ohmyzsh/ohmyzsh

## Todos
- Commenting `tsx` files, for some reason still doesnt work. 
The packages `JoosepAlviste/nvim-ts-context-commentstring` and `terrortylor/nvim-comment` should be setup correctly. 
- Changing colors themes `dark` to `light` does not update the cursor. `Kitty` (or what ever terminal) needs to also have its theme updated
- A custom `ZSH` setup, not using `ohmyzsh`. But for now my main focus is on the `nvim`

# Troubleshooting
When having trouble always run `:healthcheck`

Many features of Coc requires Python3 to be installed and pynvim as a provider for nvim. 
If you are having trouble or errors with pyx command not found.
- `brew install python`
- `brew install pyvim` 
- `python3 -m pip install pynvim --user`


