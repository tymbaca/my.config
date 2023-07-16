setopt extendedglob

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"


plugins=(git)

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
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#------------------------------------------------
# User Configuration
#------------------------------------------------
alias p3="python3"
alias p="python"
alias ip="ipython"
alias swagger-editor="docker run -p 80:8080 swaggerapi/swagger-editor:v5.0.0-alpha.63-unprivileged"
alias treee="tree -L 3"
alias zshrc="\$EDITOR \$HOME/.zshrc"
alias shrc="\$EDITOR \$HOME/.zshrc"
alias zshrc-reload="source \$HOME/.zshrc"
alias profile="\$EDITOR \$HOME/.profile"
alias emacs="/usr/local/bin/emacs"
alias e="emacsclient -c -a 'emacs'"
alias egp="echo \$GOPATH"
alias dcp="docker-compose"
alias gd="git diff | bat"
alias ds="du -hs"
alias c="clear"
alias t="tmux"
alias g="git"
alias ta="tmux attach"
alias td="tmux detach"
alias cgit='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias cg='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias f="cd \$(find . -type d -print | fzf)"
alias ff="cd \$(find * -type d -print | fzf)"

# Add bat aliases if bat installed at name "batcat"
if ! command -v bat &> /dev/null
then
    alias bat="batcat"
    alias cat="batcat -p"
else
    alias cat="bat -p"
fi

function v() {
  $EDITOR ${1:-.}
}

function av() {
  source ${1:-venv}/bin/activate
}

dotenv() {
if [ -f .env ]; then
  export $(echo $(cat .env | sed 's/#.*//g'| xargs) | envsubst)
fi
}

# Imports
source $HOME/.profile

if ! command -v nnn &> /dev/null
then
else
    source $HOME/.config/nnn/config.zsh
fi

if ! command -v jump &> /dev/null
then
else
    eval "$(jump shell zsh)"
fi
