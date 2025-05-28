setopt interactive_comments

# Autocomplete
autoload -Uz +X bashcompinit && bashcompinit
autoload -Uz +X compinit && compinit

# Load secrets
. ~/.zshrc_secrets

# Load pkg cd script
. ~/.zshrc_pkg_script

# For kubectl autocompletion to work
# autoload -Uz compinit
# compinit

# Add ssh identity if not found
ssh-add -l | grep "no identities" && ssh-add --apple-use-keychain ~/.ssh/id_ed25519

alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias espanso="vim '/Users/mma/Library/Application Support/espanso/match/base.yml'"

alias mv="mv -i"

my_cd() {
  if [ -f "$1" ]; then
    builtin cd -- "$(dirname "$1")"
  else
    builtin cd -- "$1"
  fi
}
alias cd='my_cd'

alias jwt='docker run -it --network "host" --rm -v "${PWD}:/tmp" -v "${HOME}/.jwt_tool:/root/.jwt_tool" ticarpi/jwt_tool'

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
alias stash="git stash"
alias pop="git stash pop"
alias pr="gh pr create -d"
alias prr="gh pr create --fill"
alias prd="gh pr create -d --fill"
alias gr="git rebase -i"
gri() { git rebase -i HEAD~"$@"; }
alias fixup="git rebase -i HEAD~2"
alias grc="git rebase --continue"
alias grm="git rebase master"
alias prune="git remote prune origin"
alias fwl="git push --force-with-lease"
alias grs="git reset --soft HEAD^"

alias kar="kaeter ar -p ."

alias zuse="ssh zuse -t 'tmux a'"

alias privileges="/Applications/Privileges.app/Contents/Resources/PrivilegesCLI"
alias sudo="privileges --add 2>/dev/null; sudo -E"

alias kaeter='$PANTA_HOME/scripts/kaeter.sh'
alias lint='bazel run //tools/kaeter-police:cli -- --path "$PANTA_HOME" check'
alias golint='revive -config $PANTA_HOME/revive.toml -formatter stylish ./...' #;  golangci-lint run ./...'

alias timetf='/Users/mma/dev/panta/seccloud/websec/pkg/OSAGsquid/addon/bin/timetf.pl'

# Cloud swg profile setup
cloudswg_anyconnect() {
  echo '1/2. sudo rm -rf /opt/cisco/anyconnect/profile/AnyConnectProfile*.xml && sudo pkill cisco && sudo pkill vpnagentd'
  echo '3. Connect to a13.cvpn.open.ch/token-swg-autoconnect'
  echo '4. Disconnect'
  echo '4. Login to Remote Access Cloud-SWG (ZRH) with username + password + token'
}

# Kubernetes setup
alias k="kubectl"
alias mk="minikube"
alias kx="kubectl exec -it"
alias kd="kubectl describe"
alias kctx="kubectx"
alias kns="kubens"
alias p="kubectl get pods"
alias wp="watch -n1 kubectl get pods"
source <(kubectl completion zsh)
export MINIKUBE_IN_STYLE=0

alias hcv="vault"
alias hc="vault"
export VAULT_ADDR=https://hcv.dev.open.ch

# Panta proxy setup
export PANTA_HOME="/Users/mma/dev/panta"
export PANTA=$PANTA_HOME
export WS="$PANTA_HOME/seccloud/websec/"
alias panta="cd $PANTA"

# Playground setup
alias playground="$PANTA_HOME/scripts/playground-self-service.sh"

# Workflow deployment
alias wfdeploy="$PANTA_HOME/products/mc-automation/src/workflows/re_deploy.zsh"

# Kubernetes prompt setup
source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
alias koff="kubeoff"
alias kon="kubeon"
export KUBECTX_CURRENT_FGCOLOR=$(tput setaf 6)
source "$PANTA/osse/scripts/okx.sh"

export PROXY=proxy.open.ch:8080
export http_proxy="http://$PROXY"
export HTTP_PROXY=$http_proxy
export https_proxy="http://$PROXY"
export HTTPS_PROXY=$https_proxy
export ALL_PROXY=$PROXY
export no_proxy="localhost,127.0.0.1,::1,repo.open.ch,.open.ch,.artifacts.open.ch,artifacts.open.ch,10.96.0.0/12,192.168.59.0/24,192.168.39.0/24,10.13.13.90,.privatelink.switzerlandnorth.azmk8s.io,100.113.113.0/24,.semgrep.dev,semgrep.dev"
export NO_PROXY="$no_proxy"

# build settings
# Note on REQUESTS_CA_BUNDLE: pip, python, poetry need this. Azure-cli does not work with it. But bazel-local-setup.sh wants it, so here it is.
export REQUESTS_CA_BUNDLE="${PANTA_HOME}/certs/osag-prod-cert.crt"
export NODE_EXTRA_CA_CERTS="${PANTA_HOME}/certs/osag-prod-cert.crt"
export PULLER_TIMEOUT=7200

export REQUESTS_CA_BUNDLE="$(find $HOMEBREW_CELLAR/azure-cli -name cacert.pem | grep -v pip)"
curl -s --noproxy '*' http://proxy-ca.open.ch:8081/proxyca.crt >> "$REQUESTS_CA_BUNDLE"

git config --global http.proxy http://proxy.open.ch:8080/

export PULLER_TIMEOUT=7200

# Proxy setup
PROXY_HOST=proxy.open.ch
FTP_PROXY_PORT=21

export ftp_proxy=http://${PROXY_HOST}:${FTP_PROXY_PORT}
export FTP_PROXY=http://${PROXY_HOST}:${FTP_PROXY_PORT}

# Go proxy setup
export go_exclude="github.com/Open-Systems-SASE"
export GOPROXY='https://artifacts.open.ch/artifactory/public-go-virtual'
export GONOPROXY="$go_exclude"
export GONOSUMDB="$go_exclude"
export GOPRIVATE="$go_exclude"
export GOPATH=/Users/mma/go

export JAVA_HOME=$(/usr/libexec/java_home)

# Dev certtool alias
alias certs='certtool'
alias devcerts='certtool --config $PANTA_HOME/products/certtool/src/test-config.yaml'
compdef _certtool devcerts
compdef _certtool certs

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
OKX_PS1_HOST_ENABLE=true
OKX_PS1_HOST_COLOR='37'
PS1='$(okx_ps1)'$PS1

# Kube config - only overwrite if something changed
#KUBECONFIG="~/.kube/config" existing_kube_config=$(kubectl config view --flatten)
#iKUBECONFIG="~/.kube/config:${PANTA_HOME}/configs/kube/config.yaml" merged_kube_config=$(kubectl config view --flatten)
#if [ "$existing_kube_config" != "$merged_kube_config" ]; then
#  KUBECONFIG="~/.kube/config:${PANTA_HOME}/configs/kube/config.yaml" kubectl config view --flatten > ~/.kube/config
#fi
KUBECONFIG="~/.kube/config:${PANTA_HOME}/configs/kube/config.yaml" kubectl config view --flatten > ~/.kube/config.new
diff -I 'current-context.*' -I 'namespace.*' ~/.kube/config.new ~/.kube/config > /dev/null
if [ $? -ne 0 ]; then
  mv ~/.kube/config.new ~/.kube/config
  chmod 700 ~/.kube/config
fi

# Cocoapods
export GEM_HOME=$HOME/.gem

# Path setup
# export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="${PATH}:/Users/mma/go/bin"
export PATH="${PATH}:/opt/homebrew/bin"
export PATH="${PATH}:/usr/local/idea"
export PATH="${PATH}:/Users/mma/dev/mini-magic/bin"
# export PATH="${PATH}:$(brew --prefix)/opt/python/libexec/bin"
export PATH="${PATH}:/Users/mma/dev/flutter/bin"
export PATH="/opt/homebrew/opt/ruby/bin:${PATH}"
export PATH="${GEM_HOME}/bin:${PATH}"
export PATH="$PATH":"$HOME/.pub-cache/bin"

# sqlplus setup
export ORACLE_HOME=/Applications/OSAGoraclient/client
export PATH=$PATH:$ORACLE_HOME
alias sqlplus=/Applications/OSAGoraclient/client/sqlplus

# Perl lang settings
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

source ~/perl5/perlbrew/etc/bashrc

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source /Users/mma/.docker/init-zsh.sh || true # Added by Docker Desktop

# bun completions
[ -s "/Users/mma/.bun/_bun" ] && source "/Users/mma/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
