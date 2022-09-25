# Dotfiles
An always work in progress repo for my dotfiles.

## Setup

#### Formatting and editing nvim lua
 - Follow the installation steps at https://github.com/JohnnyMorganz/StyLua

#### Nvim
- open `nvim` and run `:PackerSync`

#### For Symlinking
- run `brew install stow`
- run `stow stow/` setup stow ignore before anything else, to make sure we ignore .DS_STORE etc.
- run `stow */` then symlink everything else

#### For ZSH
- follow the instructions on https://github.com/ohmyzsh/ohmyzsh

## TODO's
- Changing colors themes `dark` to `light` does not update the cursor. `Kitty` (or what ever terminal) needs to also have its theme updated
- A custom `ZSH` setup, not using `ohmyzsh`. But for now my main focus is on `nvim`
- Move to LSP over CoC

## Troubleshooting

#### Reminders 
- When having trouble always run `:healthcheck`
- Remember to run `:PackerCompile` after updating any of the configs

### pyx command not found, while using CoC
Many features of CoC requires Python3 to be installed and pynvim as a provider for nvim. 
If you are having trouble or errors with pyx command not found.
- `brew install python`
- `brew install pyvim` 
- `python3 -m pip install pynvim --user`

### XCode errors while compiling treesitter
If the console on compiling (first time) throws some XCode errors scanner.cc etc.
You might have some symlink issues with `clang` and `gcc`. Treesitter uses `c` and `c++` to compile language parsers

I have hardcoded the treesitter compiler to `gcc` (see line 5 in `treesitter.lua`)

and linked gcc with higher priority to override apples symlink of clang:
- `cd /usr/local/bin && ln -s ./gcc-11 gcc` 
(have a look at this comment https://github.com/tree-sitter/tree-sitter-haskell/issues/34#issuecomment-892960976)


