setopt aliases

# Add bat aliases if bat installed at name "batcat"
if ! command -v bat &> /dev/null
then
    alias bat="batcat"
fi


# System
alias zshrc="\$EDITOR \$ZSHRC_DIR"
alias treee="tree -L 3"
alias T="tree -L 3 --dirsfirst -a"
alias ds="du -hs"
alias c="clear"
alias ports="lsof -i -P -n | grep LISTEN"
function v() {
  $EDITOR ${1:-.}
}
dotenv() {
if [ -f .env ]; then
  export $(echo $(cat .env | sed 's/#.*//g'| xargs) | envsubst)
fi
}

function slog() {
    if [[ -d *loggo.yaml ]] 
    then
        ${1} &> /dev/stdout | loggo stream -t *loggo.yaml
    else
        ${1} &> /dev/stdout | loggo stream 
    fi
}

function podlog() {
    if [ -z $1 ]; then
        echo "error: please provide namespace where pods are placed"
        return 1
    fi

    pod=$(kubectl get pods -o name -n $1 | fzf)
    kubectl logs $pod -n $1 | loggo stream
}

# Other
alias dcp="docker-compose"

# Git
alias g="git"
alias gch="git checkout"
alias gd="git diff | bat"
alias gdd="git diff --cached | bat"
alias gD="git diff @~..@"
alias gs="git status"
alias gl="git log"
alias gp="git push"
alias gpl="git pull"

# Tmux
alias t="tmux attach -t \$(tmux ls -F\#S | fzf)"
alias ta="tmux attach"
alias td="tmux detach"
alias tat="tmux attach -t"
alias tn="tmux new-session -s \$(basename \$PWD)"

# Fzf
alias f="cd \$(find . -type d -print | fzf)"
alias fp="cd \$(find ~/code -type d -print | fzf)"
alias fa="cd \$(find * -type d -print | fzf)"
alias ff="cd \$(find . -print | fzf)"
alias faf="cd \$(find * -print | fzf)"

# Go 
alias gr="go run main.go"
alias egp="echo \$GOPATH"
ginit() {
    go mod init $GITPROF/${1}
}

# Python
alias p3="python3"
alias p="python"
alias ip="ipython"
function av() {
  source ${1:-venv}/bin/activate
}

