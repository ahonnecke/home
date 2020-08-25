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

alias web3='docker-compose run scraper /bin/bash'

# Linux defaults, but adding for docker
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'

alias api='docker-compose -f ~/AutoDS/AutoDSApi/bin/docker-compose-api.yml'
alias all='docker-compose -f ~/AutoDS/AutoDSApi/bin/docker-compose-api.yml -f ~/AutoDS/v2-frontend/bin/docker-compose-frontend.yml -f ~/AutoDS/AutoOrderApiV2/bin/docker-compose-ao-api.yml -f ~/AutoDS/AutoDSFlaskSSE/bin/docker-compose-flasksse.yaml'
alias mysql_all='all exec db mysql -uroot -p autodsapi'
alias mysql_api='api exec db mysql -uroot -p autodsapi'
