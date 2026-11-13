function rtmux -d "SSHs to a server provided, runs tmux attach -CC"
  set -f remote_host $argv[1]
  set -e argv[1]
  command ssh $remote_host -t 'tmux -CC attach' $argv
end
