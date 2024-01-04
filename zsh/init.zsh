MYDIR="$(dirname "$(realpath "$0")")"
export ZSHRC_DIR=$MYDIR
export ZSHRC="$ZSHRC_DIR/init.zsh"

source $MYDIR/profile.zsh
source $MYDIR/commands.zsh
