# Basic directory operations
alias ...='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias a=". venv/bin/activate"
unalias gup
alias gup="git add  . ; git commit --amend --no-edit && git push origin HEAD:refs/for/master"
