setopt interactive_comments

# Load secrets
. ~/.zshrc_secrets

# For kubectl autocompletion to work
autoload -Uz compinit
compinit

# Add ssh identity if not found
ssh-add -l | grep "no identities" && ssh-add --apple-use-keychain ~/.ssh/id_ed25519

alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias espanso="vim '/Users/mma/Library/Application Support/espanso/match/base.yml'"

alias rm="rm -i"
alias mv="mv -i"

alias l="ls -alh"
alias ll="ls -alh"
alias less="less -R"
alias notify="/Users/mma/dev/editor-configs/notify"
alias finder='open -a finder'
alias grep='grep --color'

# Git aliases
alias gco="git checkout"
alias gp="git pull"
alias pull="git pull"
alias push="git push"
alias pop="git stash pop"
alias pr="gh pr create -d"
alias prune="git remote prune origin"
alias fwl="git push --force-with-lease"

alias zuse="ssh zuse -t 'tmux a'"

alias privileges="/Applications/Privileges.app/Contents/Resources/PrivilegesCLI"
alias sudo="privileges --add 2>/dev/null; sudo -E"

alias kaeter='$PANTA_HOME/scripts/kaeter.sh'
alias lint='bazel run //tools/kaeter-police:cli -- --path "$PANTA_HOME" check'

# Cloud swg profile setup
cloudswg_anyconnect() {
  echo '1/2. sudo rm -rf /opt/cisco/anyconnect/profile/AnyConnectProfile*.xml && sudo pkill cisco && sudo pkill vpnagentd'
  echo '3. Connect to a13.cvpn.open.ch/token-swg-autoconnect'
  echo '4. Disconnect'
  echo '4. Login to Remote Access Cloud-SWG (ZRH) with username + password + token'
}

# Cloud swg deploy
deploycloud() {
  # WD /Users/mma/dev/panta/seccloud/websec/kubernetes/dev/cloudswg-mma/prototype
  # rm -rf rm -rf charts/ output/ Chart.lock
  rm -rf /Users/mma/dev/panta/seccloud/websec/kubernetes/dev/cloudswg-mma/prototype/charts
  rm -rf /Users/mma/dev/panta/seccloud/websec/kubernetes/dev/cloudswg-mma/prototype/output
  rm -rf /Users/mma/dev/panta/seccloud/websec/kubernetes/dev/cloudswg-mma/prototype/Chart.lock

  # First run expected to fail
  helm template /Users/mma/dev/panta/seccloud/websec/kubernetes/dev/cloudswg-mma/prototype --dependency-update -n cloudswg-mma | mkswg apply -f - >/dev/null 2>&1
  helm template /Users/mma/dev/panta/seccloud/websec/kubernetes/dev/cloudswg-mma/prototype --dependency-update -n cloudswg-mma | mkswg apply -f - | grep -iv unchanged
}

cloudrestart() {
  mkswg rollout restart $@
}

pkg() {
  cd $PANTA_HOME/seccloud/websec/pkg/OSAG$1
}

release() {
  set -x
  cd $PANTA_HOME;
  gco master && gco -b release/OSAG${1}v${2}-kaeter || return
  scripts/kaeter.sh -p $PANTA_HOME/seccloud/websec/pkg/OSAG${1} prepare --version ${2} || return
  gh pr create -f
  set +x
}

# Kubernetes setup

alias dc="docker-compose"
alias kc="kubectl"
alias k="kubectl"
alias kcn="kubectl --namespace"
alias mk="minikube"
alias kx="kubectl exec -it"
alias kcsse="cp ~/.kube/config_osse_dev ~/.kube/config"
alias kcdev="cp ~/.kube/config_dev ~/.kube/config"
alias kclocal="cp ~/.kube/config_local ~/.kube/config"
alias kctx="kubectx"
# namespace for open-cswg-azuchn-mma-1 is proxy-6-11856
#alias kswg="kubectl -n cloudswg"
#alias kcswg="kubectl -n cloudswg"
#alias mkswg="kubectl -n cloudswg-mma"
alias kns="kubens"
source <(kubectl completion zsh)
export MINIKUBE_IN_STYLE=0

source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
alias koff="kubeoff -g"
alias kon="kubeon -g"
export KUBECTX_CURRENT_FGCOLOR=$(tput setaf 6)

alias hcv="vault"
alias hc="vault"
export VAULT_ADDR=https://hcv.dev.open.ch

# Panta proxy setup
export PANTA_HOME="/Users/mma/dev/panta"
export PANTA=$PANTA_HOME
export WS="$PANTA_HOME/seccloud/websec/"

export PROXY=proxy.open.ch:8080
export http_proxy="http://$PROXY"
export HTTP_PROXY=$http_proxy
export https_proxy="http://$PROXY"
export HTTPS_PROXY=$https_proxy
export ALL_PROXY=$PROXY
export no_proxy="localhost,127.0.0.1,::1,repo.open.ch,stash.open.ch,.open.ch,.artifacts.open.ch,artifacts.open.ch,10.96.0.0/12,192.168.59.0/24,192.168.39.0/24,10.13.13.90,.privatelink.switzerlandnorth.azmk8s.io"
export NO_PROXY="$no_proxy"
export REQUESTS_CA_BUNDLE="${PANTA_HOME}/.osag_ca.crt"
export NODE_EXTRA_CA_CERTS="${PANTA_HOME}/.osag_ca.crt"

git config --global http.proxy http://proxy.open.ch:8080/
git config --global http.https://stash.open.ch.proxy ""

export PULLER_TIMEOUT=7200

# Proxy setup
PROXY_HOST=proxy.open.ch
FTP_PROXY_PORT=21

export ftp_proxy=http://${PROXY_HOST}:${FTP_PROXY_PORT}
export FTP_PROXY=http://${PROXY_HOST}:${FTP_PROXY_PORT}

# Go proxy setup
export GOPROXY='https://artifacts.open.ch/artifactory/public-go-virtual'
export GONOPROXY="stash.open.ch"
export GONOSUMDB="stash.open.ch"
export GOPRIVATE="stash.open.ch"

export JAVA_HOME=$(/usr/libexec/java_home)


# Colors and prompt setup

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

autoload -U colors && colors
#PS1="%{$fg[green]%}%n:%{$fg[cyan]%}%1~%{$reset_color%} %% "
PS1="%{$fg[green]%}%n %{$fg[cyan]%}%~%{$reset_color%} %% "

# K8s prompt

KUBE_PS1_PREFIX='['
KUBE_PS1_SUFFIX='] '
KUBE_PS1_SYMBOL_ENABLE=true
KUBE_PS1_SYMBOL_DEFAULT='\u2388'
KUBE_PS1_SEPARATOR=':'
KUBE_PS1_SYMBOL_PADDING=false
KUBE_PS1_CTX_COLOR='37'
KUBE_PS1_NS_COLOR='36'
PS1='$(kube_ps1)'$PS1

# Cocoapods
export GEM_HOME=$HOME/.gem

# Path setup
export PATH="${PATH}:/Users/mma/go/bin"
export PATH="${PATH}:/usr/local/idea"
export PATH="${PATH}:/Users/mma/dev/mini-magic/bin"
export PATH="${PATH}:$(brew --prefix)/opt/python/libexec/bin"
export PATH="${PATH}:/Users/mma/dev/flutter/bin"
export PATH="/opt/homebrew/opt/ruby/bin:${PATH}"
export PATH="${GEM_HOME}/bin:${PATH}"

# Perl lang settings
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

source ~/perl5/perlbrew/etc/bashrc

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source /Users/mma/.docker/init-zsh.sh || true # Added by Docker Desktop
