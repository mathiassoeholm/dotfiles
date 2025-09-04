export $(grep -v '^#' ~/dotfiles/.env | xargs)

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-z zsh-autosuggestions zsh-syntax-highlighting ssh-agent yarn)

source $ZSH/oh-my-zsh.sh


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias gitui="gitui -t catpuccino.ron"
alias icat="kitty +kitten icat"
alias pn="pnpm"

# Interactive checkout tool, can be cloned from here and built from source with: cargo build --release
# https://github.com/mathiassoeholm/rust-projects
alias gci="~/git/rust-projects/git-checkout-interactive/target/release/git-checkout-interactive"

# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "EH@Machine"
  fi
}

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Make global yarn packages work.
export PATH="${PATH}:$(yarn global bin)"

# Add Rust toolchain to PATH
source "$HOME/.cargo/env"

# Enable vim mode
if [ $DOTFILES_VIM_IN_KITTY = "true" ]
then
  set -o vi
fi

# Autocomplete for terraform
# Added by runnning `terraform -install-autocomplete`
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# pnpm
export PNPM_HOME="/Users/dkmajuso/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Add Go bin to PATH
export PATH="$HOME/go/bin:$PATH"

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

function aws-profile {
    export AWS_PROFILE=$1
}

function gitci() {
	local -r commit_message="$1"

	# Check if on main branch and up to date
	local current_branch
	current_branch=$(git rev-parse --abbrev-ref HEAD)
	if [[ "$current_branch" != "main" ]]; then
		echo "Error: Not on main branch."
		return 1
	fi

	git fetch origin main
	local local_commit
	local remote_commit
	local_commit=$(git rev-parse main)
	remote_commit=$(git rev-parse origin/main)

	if [[ "$local_commit" != "$remote_commit" ]]; then
		echo "Error: Your main branch is not up to date with origin/main."
		return 1
	fi

	if [ -z "$commit_message" ]; then
		echo "Commit message is required"
		return 1
	fi

	# Fail if working tree is clean
	if git diff-index --quiet HEAD --; then
		echo "No changes to commit"
		return 1
	fi

	branch_name=$(echo "$commit_message" | tr '[:upper:]' '[:lower:]' | sed -e 's/[^a-z0-9]/-/g' -e 's/-\{2,\}/-/g' -e 's/^-//' -e 's/-$//' | cut -c1-40)
	# Add a short unique suffix to the branch name to avoid collisions
	branch_name="${branch_name}-$RANDOM"
 
	git checkout -b "$branch_name"
 
	git add .
	git commit -m "$commit_message"
	git push -u origin "$branch_name"
 
	pr_name=$(echo "$commit_message" | tr '\n' ' ' | cut -c 1-50)
	gh pr create --base main --head "$branch_name" --title "$pr_name" --body "$commit_message"
	gh pr merge --auto --squash "$branch_name"

	# Jump back to main branch
	git checkout main
}