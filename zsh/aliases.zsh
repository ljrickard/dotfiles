# directory operations
alias ...='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias dot='cd ~/.dotfiles'
alias ws='cd ~/workspace'
alias ws-go='~/workspace/go/src/github.com/sojern/go'
alias infra='~/workspace/infrastructure'

# custom scripts
alias boot="$HOME/.dotfiles/bootstrap.sh"

# python
alias a=". venv/bin/activate"

# git
unalias gup
# TODO - update so not specific to gerrit
alias gup="git add  . ; git commit --amend --no-edit && git push origin HEAD:refs/for/master"

# gloud
alias gcp="gcloud"

alias k='kubectl'
# https://learnk8s.io/blog/kubectl-productivity/
# Get current context
alias krc='kubectl config current-context'
# List all contexts
alias klc='kubectl config get-contexts -o name | sed "s/^/  /;\|^  $(krc)$|s/ /*/"'
# Change current context
alias kcc='kubectl config use-context "$(klc | fzf -e | sed "s/^..//")"'

# Get current namespace
alias krn='kubectl config get-contexts --no-headers "$(krc)" | awk "{print \$5}" | sed "s/^$/default/"'
# List all namespaces
alias kln='kubectl get -o name ns | sed "s|^.*/|  |;\|^  $(krn)$|s/ /*/"'
# Change current namespace
alias kcn='kubectl config set-context --current --namespace "$(kln | fzf -e | sed "s/^..//")"'
