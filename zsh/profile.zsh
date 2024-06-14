MYDIR="$(dirname "$(realpath "$0")")"

export EDITOR=nvim
export VISUAL="$EDITOR"

# Added by Toolbox App
export PATH="$PATH:/usr/local/bin"

export TERM="xterm-256color"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/Users/tymbaca/Applications/nvim/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.config/emacs/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME~/.local/bin:$PATH
export PATH="/Users/tymbaca/.local/bin:$PATH"
export PATH=".local/share/nvim/mason/bin":$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# GO
export GOPATH="$HOME/code/go"
export PATH=$HOME/code/go/bin:$PATH

# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/tigranrostoman/Library/Caches/Coursier/arc/https/github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.20%252B8/OpenJDK11U-jdk_x64_mac_hotspot_11.0.20_8.tar.gz/jdk-11.0.20+8/Contents/Home"
# <<< JVM installed by coursier <<<

# >>> coursier install directory >>>
export PATH="$PATH:/Users/tigranrostoman/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<

export GITPROF="github.com/tymbaca"

source $HOME/.cargo/env
