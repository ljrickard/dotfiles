# directory operations
alias ...='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias dot='cd ~/.dotfiles'
alias ws='cd ~/workspace'
alias ws-go='~/workspace/go/src/github.com/sojern/go'

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