abbr --add --set-cursor gcbj "git checkout -b jeffs/%"
abbr --add g "git"
abbr --add gc "git checkout"
abbr --add gcb "git checkout -b"
abbr --add gcm "git commit -m"
abbr --add gst "git status"
abbr --add gsy "gh repo sync"
abbr --add gu "gh repo sync"
abbr --add j "jira"
abbr --add jbu "jj bu"
abbr --add jp "jj git push"
abbr --add m "mise"
abbr --add mr "mise run"


function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

function last_history_item; echo $history[1]; end
abbr -a !! --position anywhere --function last_history_item
