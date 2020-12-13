export PATH=/home/ahonnecke/.local/bin:/home/ahonnecke/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export PATH="~/local/bin:$PATH"
export PATH="$PATH:./bin"
export PATH="~/.local/bin/aws_completer:$PATH"
export PATH="~/bin:$PATH"

export AWS_SDK_LOAD_CONFIG=true

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/bin:$PATH"

#export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

export AUTHOR_NAME='Ashton Honnecke'
export AUTHOR_EMAIL='ashton@pixelstub.com'

gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"

source ~/bin/fzf-completion.bash

## AutoDS specific settings
export GPG_TTY=$(tty)
export PATH=$PATH:$HOME/bin:$HOME/.emacs.d/bin
source ~/.awsrc

export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden -g '!{.venv,.git,*cache*,node_modules}'"
