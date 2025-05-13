export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ys"
plugins=(git)
source $ZSH/oh-my-zsh.sh
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH:$GOBIN
alias k=kubectl
plugins=(
  kube-ps1
)
source ~/kube-ps1.sh
function cluster_function() {
  info="$(ocm backplane status 2> /dev/null)"
  if [ $? -ne 0 ]; then return; fi
  clustername=$(grep "Cluster Name" <<< $info | awk '{print $3}')
  baseid=$(grep "Cluster Basedomain" <<< $info | awk '{print $3}' | cut -d'.' -f1,2)
  echo $clustername.$baseid
}
KUBE_PS1_BINARY=oc
export KUBE_PS1_CLUSTER_FUNCTION=cluster_function
PROMPT='$(kube_ps1)'$PROMPT
alias obl="ocm backplane login"
alias oblog="ocm backplane logout"