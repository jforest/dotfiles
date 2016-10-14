tmux-ssh() {
#  KEY=$1
#  shift
#  USER=$1
#  shift
  HOSTS=$*
#  if [[ -z "$HOSTS" || -z "$KEY" || -z "$USER" ]]; then
  if [[ -z "$HOSTS" ]]; then
    echo "Usage: tmux-ssh <hostlist>"
  else
    hosts=($HOSTS)
#    echo "Opening session to ${hosts[0]} with key $KEY and user $USER..."
    echo "Opening session to ${hosts[0]} "
    tmux new-window "ssh ${hosts[0]}"
    unset hosts[0];
    for i in "${hosts[@]}"; do
        echo "Opening session to $i ..."
        tmux split-window -v "ssh $i"
        tmux select-layout tiled > /dev/null
    done
    tmux select-pane -t 0
    tmux set-window-option synchronize-panes on >/dev/null
  fi
}

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# some more ls aliases
alias ls='ls -F'
#alias la='ls -A'
#alias l='ls -CF'

export EDITOR=vim

/usr/bin/env keychain $HOME/.ssh/id_rsa
. $HOME/.keychain/${HOSTNAME}-sh > /dev/null 

PATH=$PATH:$HOME/.bin:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Add perlbrew to your path
[[ -s $HOME/perl5/perlbrew/etc/bashrc ]] && source $HOME/perl5/perlbrew/etc/bashrc

export TERM=screen-256color
PS1='\[\e[37;0m\][\[\e[37;1m\]\u\[\e[37;0m\]@\[\e[31;1m\]\h\[\e[37;0m\]:\[\e[33;1m\]\W\[\e[37;0m\]]\\$ '

# Git prompt fun!
GIT_PROMPT_THEME=Solarized
GIT_PROMPT_ONLY_IN_REPO=1
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi
