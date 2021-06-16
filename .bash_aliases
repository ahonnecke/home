alias python='python3'
alias python2='python2'

alias e="emacs"
alias emacsd='emacs --daemon --with-x-toolkit=lucid --debug-init &'
alias eg="emacsclient -c -a emacs"
alias emacsbare="emacs -nw -Q --eval \"(load-theme 'misterioso)\""
alias eb="emacsbare"
alias ec="emacsclient -c -n -a ''"

alias vim="eb"
alias vi="eb"

alias ipy='ptipython'
alias dc='docker-compose'
alias dcb='docker-compose build'
alias up='docker-compose up'
alias down='docker-compose down'
alias build='docker-compose build'
alias open='xdg-open'
alias pip='pip3'
alias xit='exit'


# Linux defaults, but adding for docker
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'

alias fix_home_permissions='sudo chown -R $USER:$USER *'
alias fd=fdfind
alias tf=terraform
alias cp='cp -a'
alias toclipboard='xclip -selection clipboard'
