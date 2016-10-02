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

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
