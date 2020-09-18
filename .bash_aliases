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
alias orders='docker-compose -f ~/AutoDS/AutoOrderApiV2/bin/docker-compose-ao-api.yml'
alias frontend='docker-compose -f ~/AutoDS/v2-frontend/bin/docker-compose-frontend.yml'
alias flasksse='docker-compose -f ~/AutoDS/AutoDSFlaskSSE/bin/docker-compose-flasksse.yaml'
alias all='docker-compose -f ~/AutoDS/AutoDSApi/bin/docker-compose-api.yml -f ~/AutoDS/v2-frontend/bin/docker-compose-frontend.yml -f ~/AutoDS/AutoOrderApiV2/bin/docker-compose-ao-api.yml -f ~/AutoDS/AutoDSFlaskSSE/bin/docker-compose-flasksse.yaml'


alias alldb='all exec db mysql -uroot -proot autodsapi'
alias apidb='api exec db mysql -uroot -proot autodsapi'

alias allexec='all exec autodsapi /bin/bash'
alias apiexec='api exec autodsapi /bin/bash'

alias apimongo='api exec mongodb mongo --username root --password root'

alias reset_mysql='api up upload_shell'

alias fix_home_permissions='sudo chown -R $USER:$USER *'
