setopt aliases

# Add bat aliases if bat installed at name "batcat"
# if ! command -v bat &> /dev/null
# then
#     alias bat="batcat"
# fi


# System
alias mp=multipass
alias lt="ls -ltr"
alias zshrc="\$EDITOR \$ZSHRC_DIR"
alias treee="tree -L 3"
alias T="tree -L 3 --dirsfirst -a"
alias ds="du -hs"
alias c="clear"
alias ports="lsof -i -P -n | grep LISTEN"
function untar() {
    tar -xf ${1} --one-top-level
}
alias cd="z"

function v() {
  if [ $EDITOR = "neovide" ]; then
    $EDITOR ${1:-.} &
  else
    $EDITOR ${1:-.}
  fi
}

function vd() {
  neovide ${1:-.} &
}

dotenv() {
if [ -f .env ]; then
  export $(echo $(cat .env | sed 's/#.*//g'| xargs) | envsubst)
fi
}

function slog() {
    if [[ -d *loggo.yaml ]] 
    then
        ${@:1} &> /dev/stdout | loggo stream -t *loggo.yaml
    else
        ${@:1} &> /dev/stdout | loggo stream 
    fi
}

function replacespaces() {
    for file in *' '*; do
      mv -- "$file" "${file// /_}"
    done
}

# utility funcs

function check-ns() {
    if [ -z $1 ]; then
        echo "error: please provide namespace where pods are placed" >&2
        return 1
    fi
}

function select-ns() {
    echo $kubenamespaces | tr ' ' '\n' | fzf
}

function try-ns() {
    if [ -z $1 ]; then
        select-ns
    else
        echo $1
    fi
}

# user commands

function podlist() {
    ns=$(try-ns $1)
    kubectl get pods -o name -n "$ns"
}

function podlog() {
    ns=$(try-ns $1)

    pod=$(podselect $ns)
    kubectl logs -f $pod -n $ns | loggo stream
}

function podexec() {
    1=$(try-ns $1)

    pod=$(podselect $1)
    kubectl exec -n $1 --stdin --tty $pod -- ${@:2}
}

function podselect() {
    ns=$(try-ns $1)

    echo $(kubectl get pods -o name -n $ns | fzf)
}

function podrestart() {
    if [ -z $1 ]; then
        echo "specify deployment name"
        exit 1
    fi

    ns=$(try-ns $2)

    kubectl rollout restart deployment $1 -n $ns
}

function clusterselect() {
    tsh kube ls | awk 'NR>2{print $1}' | fzf | xargs -I {} tsh kube login {}
}

kubenamespaces="logisticcloud logistic-tariff logistic-route wb-drive logistics"
cmds="logs pods clusters sh bash"

function kube-delete-deployment() {
    kubectl get deployments | awk 'NR>1{print $1}' | fzf | xargs -I {} kubectl delete deployment/{}
}

function kube() {
    ns=$(select-ns)
    cmd=$(echo $cmds | tr ' ' '\n' | fzf)
    # echo $ns $cmd
    case $cmd in 
        "clusters")
            clusterselect
            ;;
        "logs")
            podlog $ns
            ;;

        "pods")
            podlist $ns
            ;;

        "sh")
            podexec $ns sh
            ;;

        "bash")
            podexec $ns bash
            ;;
    esac
}

alias k=kubectl

function hldssh-dev() {
    sshpass -p $HLD_PASSWORD ssh $HLD_USER@$HLD_DEV_HOST
}

function hldssh-stage() {
    sshpass -p $HLD_PASSWORD ssh $HLD_USER@$HLD_STAGE_HOST
}

# HOLODILNIK
function hldlogs-dev() {
    hldlogs $HLD_DEV_HOST $1 $2
}

function hldlogs-stage() {
    hldlogs $HLD_STAGE_HOST $1 $2
}

function hldlogs() {
    host=$1
    service=$2
    if [ $# -eq 3 ]; then
        tail="--tail $3"
    fi
    sshpass -p $HLD_PASSWORD ssh $HLD_USER@$host "sudo docker ps" | awk -v service_var="$service" '$2 ~ 'service_var' {print $1}' | xargs -I {} sshpass -p $HLD_PASSWORD ssh $HLD_USER@$host "sudo docker logs $tail -f {}" | hl
}

# Other
alias vv="nvim --listen /tmp/godot.pipe"
alias dcp="docker-compose"
alias drm="docker ps --all | awk '(NR>1){print}' | fzf | awk '{print $1}' | xargs -I {} docker rm -f {}"
alias ts="task"
function hex() {
    hexyl $1 | less
}
#macro to kill the docker desktop app and the VM (excluding vmnetd -> it's a service)
function kdo() {
    ps ax | grep -i docker | egrep -iv 'grep|com.docker.vmnetd' | awk '{print $1}' | xargs kill
}

# Git
alias g="git"
alias gw="git switch"
alias gwd="git switch --detach"
# alias gch="git checkout"
# function gch {
#     if [ -z $1 ]; then
#         git branch -a | awk '!/\*/{print}' | fzf | xargs -I {} git checkout {}
#     else
#         git checkout ${@:1}
#     fi
# }
alias gww='git branch --sort=-committerdate | grep -v "^\*" |fzf --height=20% --reverse --info=inline | xargs git switch'

function cc {
    if [ -z $1 ]; then
        git commit
    else
        git commit -m $1
    fi
    git push
}

alias gd="git diff"
alias gdd="git diff --cached"
alias gD="git diff @~..@"
alias gs="git status"
alias gsh="git push"
alias add="git add"
alias gw="git switch"
alias gwd="git switch --detach"
alias gl="git pull"
alias gp="git push"
alias glg="git log --stat"

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
# alias ip="ipython"
function av() {
  source ${1:-venv}/bin/activate
}

