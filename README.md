# Dotfiles

An always work in progress repo for my dotfiles.

## Setup

#### For Symlinking

1. Run `brew install stow`
2. Run `stow stow/` setup stow ignore before anything else, to make sure we ignore .DS_STORE etc.
3. Try running `stow */ --verbose=2 --simulate` to see what will happen, before running the next command
4. Run `stow */` to symlink everything else

#### For ZSH

- follow the instructions on https://github.com/ohmyzsh/ohmyzsh

## Troubleshooting

#### Make sure that you have neovim 8.0 installed

#### Reminders

- When having trouble always run `:healthcheck`

### XCode errors while compiling treesitter

If the console on compiling (first time) throws some XCode errors scanner.cc etc.
You might have some symlink issues with `clang` and `gcc`. Treesitter uses `c` and `c++` to compile language parsers

I have hardcoded the treesitter compiler to `gcc` (see line 5 in `treesitter.lua`)

and linked gcc with higher priority to override apples symlink of clang:

- `cd /usr/local/bin && ln -s ./gcc-11 gcc`
  (have a look at this comment https://github.com/tree-sitter/tree-sitter-haskell/issues/34#issuecomment-892960976)
